require_relative '../basic_remote/requestor'
require_relative 'book'

class LibraryProxy

  def initialize
    @r = Requestor.instance
  end

  def add_book(book)

    params={} 

    params[:book_name] = book.name
    params[:http_action] = "put"
    params[:name]= book.name
    params[:qtd]=book.qtd

    p @r.invoke("igor-app-pd", "library", params)
  end

  def rent_book(book)

    params={} 

    params[:http_action] = "post"
    params[:request_type] ="lend"
    params[:book] = book.name

    p @r.invoke("igor-app-pd", "library", params)
  end

  def return_book(book)

    params={} 

    params[:http_action] = "post"
    params[:request_type] ="return"
    params[:book] = book.name

    p @r.invoke("igor-app-pd", "library", params)
  end

  def delete_book(book)

    params={}

    params[:http_action] = "delete"
    params[:name] = book.name

    p @r.invoke("igor-app-pd", "library", params)

  end
end

def teste

  puts "-------Biblioteca - Lado Clinte -------"
  puts "-Insira o nome do livro e sua quantidade:"
  name= gets.chomp!
  qtd= gets.chomp!

  puts "-Criando Livro"
  book = Book.new(name,qtd)

  l = LibraryProxy.new

  puts "\n\n-Adicionando livro ao App Remoto"
  puts "-O app remoto respondeu:"
  l.add_book(book)

  puts "\n\n-Alugando livro"
  puts "-O app remoto respondeu:"
  l.rent_book(book)

  puts "\n\n-Retornando livro ao App Remoto"
  puts "-O app remoto respondeu:"
  l.return_book(book)

  puts "\n\n-Alugando livro novamente"
  puts "-O app remoto respondeu:"
  l.rent_book(book)

  puts "\n\n-Alugando um livro existentee"
  puts "-O app remoto respondeu:"
  l.rent_book(Book.new("LivroUm", 10))

end

teste