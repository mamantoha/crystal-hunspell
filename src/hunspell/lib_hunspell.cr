@[Link("hunspell")]
lib LibHunspell
  type Hunhandle = Void*
  fun create = Hunspell_create(affpath : LibC::Char*, dpath : LibC::Char*) : Hunhandle
  fun create_key = Hunspell_create_key(affpath : LibC::Char*, dpath : LibC::Char*, key : LibC::Char*) : Hunhandle
  fun destroy = Hunspell_destroy(p_hunspell : Hunhandle)
  fun add_dic = Hunspell_add_dic(p_hunspell : Hunhandle, dpath : LibC::Char*) : LibC::Int
  fun spell = Hunspell_spell(p_hunspell : Hunhandle, x1 : LibC::Char*) : LibC::Int
  fun get_dic_encoding = Hunspell_get_dic_encoding(p_hunspell : Hunhandle) : LibC::Char*
  fun suggest = Hunspell_suggest(p_hunspell : Hunhandle, slst : LibC::Char***, word : LibC::Char*) : LibC::Int
  fun suffix_suggest = Hunspell_suffix_suggest(p_hunspell : Hunhandle, slst : LibC::Char***, word : LibC::Char*) : LibC::Int
  fun analyze = Hunspell_analyze(p_hunspell : Hunhandle, slst : LibC::Char***, word : LibC::Char*) : LibC::Int
  fun stem = Hunspell_stem(p_hunspell : Hunhandle, slst : LibC::Char***, word : LibC::Char*) : LibC::Int
  fun stem2 = Hunspell_stem2(p_hunspell : Hunhandle, slst : LibC::Char***, desc : LibC::Char**, n : LibC::Int) : LibC::Int
  fun generate = Hunspell_generate(p_hunspell : Hunhandle, slst : LibC::Char***, word : LibC::Char*, word2 : LibC::Char*) : LibC::Int
  fun generate2 = Hunspell_generate2(p_hunspell : Hunhandle, slst : LibC::Char***, word : LibC::Char*, desc : LibC::Char**, n : LibC::Int) : LibC::Int
  fun add = Hunspell_add(p_hunspell : Hunhandle, word : LibC::Char*) : LibC::Int
  fun add_with_affix = Hunspell_add_with_affix(p_hunspell : Hunhandle, word : LibC::Char*, example : LibC::Char*) : LibC::Int
  fun remove = Hunspell_remove(p_hunspell : Hunhandle, word : LibC::Char*) : LibC::Int
  fun free_list = Hunspell_free_list(p_hunspell : Hunhandle, slst : LibC::Char***, n : LibC::Int)
end
