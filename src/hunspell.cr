require "./hunspell/**"

class Hunspell
  @handle : LibHunspell::Hunhandle

  def initialize(@handle : LibHunspell::Hunhandle)
    raise "Failed to initialize Hunspell." unless @handle
  end

  def initialize(aff_path : String, dict_path : String)
    handle = LibHunspell._create(aff_path, dict_path)

    initialize handle
  end

  # Returns dictionary encoding
  def encoding : String
    read_string(LibHunspell._get_dic_encoding(@handle))
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

  private def make_list(n : Int32, slst : Pointer(Pointer(UInt8))) : Array(String)
    words = [] of String

    n.times do |i|
      words << read_string(slst[i])
    end

    words
  end

  private def read_string(pointer : Pointer(UInt8)) : String
    i = 0

    loop do
      code = pointer[i]
      break if code == 0
      i += 1
    end

    String.new(pointer.to_slice(i))
  end
end
