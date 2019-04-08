require "./hunspell/**"

class Hunspell
  @handle : LibHunspell::Hunhandle

  # Known directories to search within for dictionaries.
  @@directories = [
    # Ubuntu
    "/usr/share/hunspell",
    # macOS brew-installed hunspell
    File.expand_path("~/Library/Spelling"),
    "/Library/Spelling",
  ]

  def self.directories : Array(String)
    @@directories
  end

  def self.directories=(directories)
    @@directories = directories
  end

  def initialize(@handle : LibHunspell::Hunhandle)
    raise "Failed to initialize Hunspell." unless @handle
  end

  def initialize(aff_path : String, dict_path : String)
    unless File.file?(aff_path)
      raise ArgumentError.new("Invalid aff path #{aff_path.inspect}")
    end

    unless File.file?(dict_path)
      raise ArgumentError.new("Invalid dict path #{dict_path.inspect}")
    end

    handle = LibHunspell._create(aff_path, dict_path)
    initialize(handle)
  end

  def initialize(locale : String)
    @@directories.each do |directory|
      aff_path = File.join(directory, "#{locale}.aff")
      dict_path = File.join(directory, "#{locale}.dic")

      if File.file?(aff_path) && File.file?(dict_path)
        return initialize(aff_path, dict_path)
      end
    end

    raise ArgumentError.new("Unable to find the dictionary #{locale.inspect} in any of the directories.")
  end

  # Returns dictionary encoding
  def encoding : String
    String.new(LibHunspell._get_dic_encoding(@handle))
  end

  # Spellcheck word
  def spellcheck(word : String) : Bool
    result = LibHunspell._spell(@handle, word)
    result == 0 ? false : true
  end

  # Search suggestions
  def suggest(word : String) : Array(String)
    n = LibHunspell._suggest(@handle, out slst, word)
    make_list(n, slst)
  end

  # Morphological analysis of the word
  def analyze(word : String) : Array(String)
    n = LibHunspell._analyze(@handle, out slst, word)
    make_list(n, slst)
  end

  def stem(word : String) : Array(String)
    n = LibHunspell._stem(@handle, out slst, word)
    make_list(n, slst)
  end

  # Adds a word to the dictionary.
  def add(word : String) : Int32
    LibHunspell._add(@handle, word)
  end

  # Adds a word to the dictionary with affix flags.
  def add_with_affix(word : String, example : String) : Int32
    LibHunspell._add_with_affix(@handle, word, example)
  end

  # Removes a word to the dictionary.
  def remove(word : String) : Int32
    LibHunspell._remove(@handle, word)
  end

  private def make_list(n : Int32, slst : Pointer(Pointer(UInt8))) : Array(String)
    n.times.reduce([] of String) do |words, i|
      words << String.new(slst[i])
    end
  end
end
