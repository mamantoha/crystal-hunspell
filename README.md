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

Ensure to close `Hunspell` instance after using.

```crystal
hunspell.close
```

Below are some simple examples for how to use the repository.

### Spelling

It's a simple task to ask if a particular word is in the dictionary.

```crystal
hunspell.spellcheck("correct")
# => true

hunspell.spellcheck("incorect")
# => false
```

This will only ever return `true` or `false`, and won't give suggestions about why it might be wrong. It also depends on your choice of dictionary.

### Suggestions

If you want to get a suggestion from Hunspell, it can provide a corrected label given a basestring input.

```crystal
hunspell.suggest("arbitrage")
# => ["arbitrage", "arbitrages", "arbitrager", "arbitraged", "arbitrate"]
```

### Suffix Match

```crystal
hunspell.suffix_suggest("do")
# => ["doing", "doth", "doer", "dos", "do's", "doings", "doers"]
```

### Stemming

The module can also stem words, providing the stems for pluralization and other inflections.

```crystal
hunsell.stem("fishing")
# => ["fishing", "fish"]
```

### Analyze

Like stemming but return morphological analysis of the input instead.

```crystal
hunspell.analyze("permanently")
# => [" st:permanent fl:Y"]
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
