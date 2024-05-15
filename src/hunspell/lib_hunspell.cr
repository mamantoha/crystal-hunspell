@[Link("hunspell")]
lib LibHunspell
  fun create = Hunspell_create(affpath : Pointer(LibC::Char), dpath : Pointer(LibC::Char)) : Pointer(Void)
  fun create_key = Hunspell_create_key(affpath : Pointer(LibC::Char), dpath : Pointer(LibC::Char), key : Pointer(LibC::Char)) : Pointer(Void)
  fun destroy = Hunspell_destroy(p_hunspell : Pointer(Void))
  fun add_dic = Hunspell_add_dic(p_hunspell : Pointer(Void), dpath : Pointer(LibC::Char)) : LibC::Int
  fun spell = Hunspell_spell(p_hunspell : Pointer(Void), x1 : Pointer(LibC::Char)) : LibC::Int
  fun get_dic_encoding = Hunspell_get_dic_encoding(p_hunspell : Pointer(Void)) : Pointer(LibC::Char)
  fun suggest = Hunspell_suggest(p_hunspell : Pointer(Void), slst : Pointer(Pointer(Pointer(LibC::Char))), word : Pointer(LibC::Char)) : LibC::Int
  fun suffix_suggest = Hunspell_suffix_suggest(p_hunspell : Pointer(Void), slst : Pointer(Pointer(Pointer(LibC::Char))), word : Pointer(LibC::Char)) : LibC::Int
  fun analyze = Hunspell_analyze(p_hunspell : Pointer(Void), slst : Pointer(Pointer(Pointer(LibC::Char))), word : Pointer(LibC::Char)) : LibC::Int
  fun stem = Hunspell_stem(p_hunspell : Pointer(Void), slst : Pointer(Pointer(Pointer(LibC::Char))), word : Pointer(LibC::Char)) : LibC::Int
  fun stem2 = Hunspell_stem2(p_hunspell : Pointer(Void), slst : Pointer(Pointer(Pointer(LibC::Char))), desc : Pointer(Pointer(LibC::Char)), n : LibC::Int) : LibC::Int
  fun generate = Hunspell_generate(p_hunspell : Pointer(Void), slst : Pointer(Pointer(Pointer(LibC::Char))), word : Pointer(LibC::Char), word2 : Pointer(LibC::Char)) : LibC::Int
  fun generate2 = Hunspell_generate2(p_hunspell : Pointer(Void), slst : Pointer(Pointer(Pointer(LibC::Char))), word : Pointer(LibC::Char), desc : Pointer(Pointer(LibC::Char)), n : LibC::Int) : LibC::Int
  fun add = Hunspell_add(p_hunspell : Pointer(Void), word : Pointer(LibC::Char)) : LibC::Int
  fun add_with_affix = Hunspell_add_with_affix(p_hunspell : Pointer(Void), word : Pointer(LibC::Char), example : Pointer(LibC::Char)) : LibC::Int
  fun remove = Hunspell_remove(p_hunspell : Pointer(Void), word : Pointer(LibC::Char)) : LibC::Int
  fun free_list = Hunspell_free_list(p_hunspell : Pointer(Void), slst : Pointer(Pointer(Pointer(LibC::Char))), n : LibC::Int)
end
