module I18n
  module Backend
    abstract class Base

      # ABSTRACT METHODS
    
      # lookup for the key and return the value
      abstract def lookup(locale : String, key : String) : Hash(String, Hash(String, String)) | Hash(String, String) | String

      # available locales
      abstract def available_locales : Array(String)

      # CONCRETE METHODS
      
      # Lookup the key in the specified locale
      # if the key is not found, or has no value the key will be returned
      def lookup_or_key(locale : String, key : String) : Hash(String, Hash(String, String)) | Hash(String, String) | String
        return lookup(locale, key) || key
      end

      # return number formats
      def number(locale : String) : Hash(String, String)
        _sub_format(locale, "number")
      end

      # return currency formats
      def currency(locale : String) : Hash(String, String)
        _sub_format(locale, "currency")
      end

      # return date formats
      def date(locale : String) : Hash(String, String)
        _sub_format(locale, "date")
      end

      # return time formats
      def time(locale : String) : Hash(String, String)
        _sub_format(locale, "time")
      end

      # ensure hash
      # this will only be passed a Hash or nil, but the compiler doesn't know
      # that.
      protected def _ensure_hash(hash : (Hash(String, String) | String | ::Nil ) ) : Hash(String, String)
        if (!hash.is_a?(Hash))
          return Hash(String, String).new
        end

        return hash as Hash(String, String)
      end

      protected def _sub_format(locale : String, format : String) : Hash(String, String)
        formats_hash = self.lookup_or_key(locale, "__formats__")
        if formats_hash.is_a? Hash && formats_hash.has_key?(format)
          return formats_hash[format] as Hash(String, String)
        end
        return {} of String => String
      end
    end
  end
end
