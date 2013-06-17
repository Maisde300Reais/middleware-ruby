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

    params[:book_id]=book.id
    params[:http_action] = "post"

    p @r.invoke("igor-app-pd", "rent_book", params)
  end

  def return_book(book)

    params={} 

    params[:book_id]=book.id
    params[:client_id]=client.id
    params[:http_action] = "post"

    p @r.invoke("library", "return_book", params)
  end

end

def teste
  book = Book.new("Chapeuzinho Vermelho",20)

  l = LibraryProxy.new

  puts l.add_book(book)
end