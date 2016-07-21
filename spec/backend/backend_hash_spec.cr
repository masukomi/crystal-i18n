require "spec"
require "../../src/i18n/backend/backend_hash"

describe I18n::Backend::BackendHash do
  locale_data = {
    "eo" => {
      "hello" => "Saluton",
      "num_dollars" => {
        "1" => "Mi havas unu dolaro",
        "2" => "Mi havas %d dolaroj",
        "3.." => "Mi havas %d dolaroj"
      },
      "__formats__" => {
        "number" => {
          "decimal_separator" => '\u2009'.to_s, # thin space
          "precision_separator" => ","
        },
        "currency" => {
          "symbol" => "$",
          "name" => "dollar",
          "format" => "$%s"
        },
        "date" => {
            "default" => "%Y-%m-%d",
            "long" => "%A, %d of %B %Y"

        }
      }
    }
  }

  bogus_locale = Hash(String, Hash(String, Hash(String, Hash(String, String)) |
                                   Hash(String, String) | String)).new()
  bh = I18n::Backend::BackendHash.new(locale_data)
  empty_bh = I18n::Backend::BackendHash.new( bogus_locale )

  it "should lookup a simple string value" do
    bh.lookup("eo", "hello").should(eq(locale_data["eo"]["hello"]))
  end

  it "should lookup a hash value" do
    bh.lookup("eo", "num_dollars").should(eq(locale_data["eo"]["num_dollars"]))
  end

  it "should return an array of available locales" do
    bh.available_locales.should(eq(["eo"]))
  end

  ## These tests actually test Backend::Base

  it "should return the key if it was missing" do
    bh.lookup_or_key("eo", "bogus").should(eq("bogus"))
  end
  
  it "should return the key if the locale was missing" do
    bh.lookup_or_key("nope", "bogus").should(eq("bogus"))
  end

  it "should return a hash of number formats" do
    bh.number("eo").should(eq(locale_data["eo"]["__formats__"]["number"]))
  end

  it "should return a hash even when no number format exists" do
    empty_bh.number("eo").should(eq({} of String => String))
  end

  it "should return a hash of currency formats" do
    bh.currency("eo").should(eq(locale_data["eo"]["__formats__"]["currency"]))
  end

  it "should return a hash of date formats" do
    bh.date("eo").should(eq(locale_data["eo"]["__formats__"]["date"]))
  end



end
