require_relative 'book'
require_relative 'user'

class Library 
  attr_accessor :books, :clients

  def initialize
    @books={}
    @clients={}
  end

  def add_book(book)
    @books[book.id]=book
  end

  def add_client(client)
    @clients[client.id]=client
  end

  def rent_book(client, book)
    @clients[client.id].rented_books[book.id]=book
    @books[book.id].status=:rented
  end

  def return_book(client, book)
    @clients[client.id].rented_books.delete(book.id)
    @books[book.id].status=:available
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
