require_relative 'book'
require_relative 'client'

class Library 
  attr_accessor :books, :clients

  def initialize
    @books={}
    @clients={}
  end

  def add_book(params)
    book = Book.new(params["book_id"], params["book_name"])
    @books[book.id]=book
    return "> Livro " + @books[book.id].name + " adicionado com sucesso."
  end

  def add_client(params)
    client = Client.new(params["client_id"], params["client_name"])
    @clients[client.id]=client
    return "> Cliente #{@clients[client.id].name} cadastrado com sucesso."
  end

  def rent_book(params)
    book = @books[params["book_id"]]
    @clients[params["client_id"]].rented_books[params["book_id"]]= book
    @books[params["book_id"]].status= :rented

    #isso imprime só no servidor
    puts @clients[params["client_id"]].rented_books

    return "> Livro locado com sucesso!"
  end

  def return_book(params)   

    @clients[params["client_id"]].rented_books.delete(params["book_id"])
    @books[params["book_id"]].status= :available

    #isso imprime só no servidor
    puts @clients[params["client_id"]].rented_books

    return "> Livro retornado com sucesso!"
  end

end


def teste

  book1 = Book.new(1,"Chapeuzinho Vermelho")
  book2 = Book.new(2,"Branca de Neve")
  book3 = Book.new(3,"Rapunzel")

  client1 = User.new(1, "Igor")
  client2 = User.new(2, "Joaquim")

  lib = Library.new

  lib.add_client client1
  lib.add_client client2

  lib.add_book book1
  lib.add_book book2
  lib.add_book book3

  lib.rent_book client1, book1

  puts client1.rented_books

end
