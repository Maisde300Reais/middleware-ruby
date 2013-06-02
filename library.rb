class Library
  def get_all_books(params)
    "{ book: Livro bolado }" * params["qtd"].to_i
  end

  def add_book(params)
    "Livro: " + params["nome"] + " adicionado"
  end
end