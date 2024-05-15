require "./hunspell/**"

class Hunspell
  @handle : Pointer(Void)

  # Known directories to search within for dictionaries.
  @@directories = [
    # Ubuntu
    "/usr/share/hunspell",
    # macOS brew-installed hunspell
    File.expand_path("~/Library/Spelling"),
    "/Library/Spelling",
    # Fedora
    "/usr/share/myspell",
  ]

  BULK_METHODS = ["suggest", "suffix_suggest", "stem", "analyze"]

  def self.directories : Array(String)
    @@directories
  end

  def self.directories=(directories)
    @@directories = directories
  end

  def initialize(@handle : Pointer(Void))
    raise "Failed to initialize Hunspell." unless @handle
    @closed = false
  end

  def initialize(aff_path : String, dict_path : String)
    unless File.file?(aff_path)
      raise ArgumentError.new("Invalid aff path #{aff_path.inspect}")
    end

    unless File.file?(dict_path)
      raise ArgumentError.new("Invalid dict path #{dict_path.inspect}")
    end

    handle = LibHunspell.create(aff_path, dict_path)
    initialize(handle)
  end

  def initialize(locale : String)
    @@directories.each do |directory|
      aff_path = File.join(directory, "#{locale}.aff")
      dict_path = File.join(directory, "#{locale}.dic")

      if File.file?(aff_path) && File.file?(dict_path)
        handle = LibHunspell.create(aff_path, dict_path)
        return initialize(handle)
      end
    end

    raise ArgumentError.new("Unable to find the dictionary #{locale.inspect} in any of the directories.")
  end

  def finalize
    close
  end

  def close
    LibHunspell.destroy(@handle) unless @closed
    @closed = true
  end

  def version : String
    version_match = `hunspell -vv`.match(/Hunspell (\d+\.\d+\.\d+)/)

    version_match ? version_match[1] : ""
  end

  # Returns dictionary encoding
  def encoding : String
    String.new(LibHunspell.get_dic_encoding(@handle))
  end

  # Check if a particular `word` is in the dictionary
  def spell?(word : String) : Bool
    LibHunspell.spell(@handle, word) != 0
  end

  # Search suggestions
  def suggest(word : String) : Array(String)
    n = LibHunspell.suggest(@handle, out slst, word)
    make_list(n, slst)
  end

  def suffix_suggest(word : String) : Array(String)
    n = LibHunspell.suffix_suggest(@handle, out slst, word)
    make_list(n, slst)
  end

  # Morphological analysis of the word
  def analyze(word : String) : Array(String)
    n = LibHunspell.analyze(@handle, out slst, word)
    make_list(n, slst)
  end

  def stem(word : String) : Array(String)
    n = LibHunspell.stem(@handle, out slst, word)
    make_list(n, slst)
  end

  {% for method in BULK_METHODS %}
    def bulk_{{method.id}}(words : Array(String)) : Hash(String, Array(String))
      words.each_with_object({} of String => Array(String)) do |word, memo|
        memo[word] = {{method.id}}(word)
      end
    end
  {% end %}

  # Adds a word to the dictionary.
  def add(word : String) : Int32
    LibHunspell.add(@handle, word)
  end

  # Adds a word to the dictionary with affix flags.
  def add(word : String, example : String) : Int32
    LibHunspell.add_with_affix(@handle, word, example)
  end

  # Removes a word to the dictionary.
  def remove(word : String) : Int32
    LibHunspell.remove(@handle, word)
  end

  private def make_list(n : Int32, slst : Pointer(Pointer(UInt8))) : Array(String)
    n.times.reduce([] of String) do |words, i|
      words << String.new(slst[i])
    end
  ensure
    LibHunspell.free_list(@handle, pointerof(slst), n)
  end
end
