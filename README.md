# crystal-hunspell

[![CI](https://github.com/mamantoha/crystal-hunspell/actions/workflows/ci.yml/badge.svg)](https://github.com/mamantoha/crystal-hunspell/actions/workflows/ci.yml)
[![GitHub release](https://img.shields.io/github/release/mamantoha/crystal-hunspell.svg)](https://github.com/mamantoha/crystal-hunspell/releases)
[![License](https://img.shields.io/github/license/mamantoha/crystal-hunspell.svg)](https://github.com/mamantoha/crystal-hunspell/blob/master/LICENSE)

Crystal bindings for Hunspell.

## Installation

Before installing `crystal-hunspell` ensure you have [hunspell](https://github.com/hunspell/hunspell) already installed:

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     hunspell:
       github: mamantoha/crystal-hunspell
   ```

2. Run `shards install`

## Usage

```crystal
require "hunspell"
```

Open a dictionary:

```crystal
hunspell = Hunspell.new("/usr/share/hunspell/en_US.aff", "/usr/share/hunspell/en_US.dic")
```

or

```crystal
hunspell = Hunspell.new("en_US")
```

Check if a word is valid:

```crystal
hunspell.spellcheck("correct")
# => true

hunspell.spellcheck("incorect")
# => false
```

Find the stems of a word:

```crystal
hunsell.stem("fishing")
# => ["fishing", "fish"]
```

Suggest alternate spellings for a word:

```crystal
hunspell.suggest("arbitrage")
# => ["arbitrage", "arbitrages", "arbitrager", "arbitraged", "arbitrate"]
```

Suffix match:

```crystal
hunspell.suffix_suggest("do")
# => ["doing", "doth", "doer", "dos", "do's", "doings", "doers"]
```

Ensure to close `Hunspell` instance after using.

```crystal
hunspell.close
```

### Bulk Requests

You can also request bulk actions against Hunspell. Currently `suggest`, `suffix_suggest`, `stem`, and `analyze` are bulk requestable.

```crystal
hunspell.bulk_suggest(["correct", "incorect"])
# => {"correct"  => ["correct", "corrects", "cor rect", "cor-rect"],
      "incorect" => ["incorrect", "correction", "corrector", "injector", "correct"]}

hunspell.bulk_suffix_suggest(["cat", "do"])
# => {"cat" => ["cats", "cat's"],
      "do"  => ["doing", "doth", "doer", "dos", "do's", "doings", "doers"]}

hunspell.bulk_stem(["stems", "currencies"])
# => {"stems" => ["stem"], "currencies" => ["currency"]}

hunspell.bulk_analyze(["dog", "permanently"])
# => {"dog" => [" st:dog"], "permanently" => [" st:permanent fl:Y"]}
```

## Development

```
sudo apt install libclang-dev libhunspell-dev
```

Generate new bindings for Hunspell

```console
crystal ./lib/crystal_lib/src/main.cr src/hunspell/lib_hunspell.cr.in > src/hunspell/lib_hunspell.cr
```

## Contributing

1. Fork it (<https://github.com/mamantoha/crystal-hunspell/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Anton Maminov](https://github.com/mamantoha) - creator and maintainer
