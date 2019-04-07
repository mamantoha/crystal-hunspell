# crystal-hunspell

[![Build Status](https://travis-ci.org/mamantoha/crystal-hunspell.svg?branch=master)](https://travis-ci.org/mamantoha/crystal-hunspell)
[![GitHub release](https://img.shields.io/github/release/mamantoha/crystal-hunspell.svg)](https://github.com/mamantoha/crystal-hunspell/releases)
[![License](https://img.shields.io/github/license/mamantoha/crystal-hunspell.svg)](https://github.com/mamantoha/crystal-hunspell/blob/master/LICENSE)

Crystal bindings for Hunspell.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     hunspell:
       github: mamantoha/crystal-hunspell
   ```

2. Run `shards install`

## Usage

Open a dictionary:

```crystal
require "hunspell"

# instantiate Hunspell with English affix and dictionary files
hunspell = Hunspell.new("/usr/share/hunspell/en_US.aff", "/usr/share/hunspell/en_US.dic")
```

Check if a word is valid:

```crystall
hunspell.spellcheck("crystal")
# => true

hunspell.spellcheck("cristal")
# => false
```

Find the stems of a word:

```crystall
hunsell.stem("fishing")
# => ["fishing", "fish"]
```

Suggest alternate spellings for a word:

```crystal
hunspell.suggest("arbitrage")
# => ["arbitrage", "arbitrages", "arbitrager", "arbitraged", "arbitrate"]
```

## Contributing

1. Fork it (<https://github.com/mamantoha/crystal-hunspell/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Anton Maminov](https://github.com/mamantoha) - creator and maintainer
