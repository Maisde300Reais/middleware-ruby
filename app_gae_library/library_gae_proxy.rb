require_relative '../basic_remote/requestor'
require_relative 'book'

class LibraryProxy

  def initialize
    @r = Requestor.instance
  end

  def add_book(book)

    params={} 

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
end

def teste
  book = Book.new("Chapeuzinho Vermelho",20)

  l = LibraryProxy.new

  l.add_book(book)

  l.rent_book(book)

  l.return_book(book)
end

teste