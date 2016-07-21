# i18n

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  i18n:
    github: whity/crystal-i18n
```

## Usage


```crystal
require "i18n/backend/yaml"

# create a i18n object
i18n = I18n.from_yaml_files("[folder where the locale files are located]")

# simple translation
i18n.translate("hello")

# pluralization
i18n.translate("new_message", count: 2)

# number format
i18n.number(123.to_s)

# currency format
i18n.currency(12345.to_s)

# time format
i18n.time(Time.now)

# date format
i18n.date(Time.now, format: "long")
```

## Data Structure
Your translation files must represent a Hash, with string keys. Values must be
of type `String | Hash(String, String | Hash)`

### Reserved Keys
#### Number Formats
Number formats must be stored as a `Hash(String, String)` under the top level
key `__formats__.number`

#### Currency Formats
Currency formats must be stored as a `Hash(String, String)` under the top level
key `__formats__.currency`


#### Date Formats
Date formats must be stored as a `Hash(String, String)` under the top level
key `__formats__.date`

#### Time Formats
Time formats must be stored as a `Hash(String, String)` under the top level
key `__formats__.time`

## Contributing

1. Fork it ( https://github.com/[your-github-name]/i18n/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- whity(https://github.com/whity) André Brás - creator, maintainer
