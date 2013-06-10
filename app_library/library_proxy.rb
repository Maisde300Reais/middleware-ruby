require_relative '../basic_remote/requestor'
require_relative 'library'
require_relative 'client'
require_relative 'book'

class LibraryProxy

  def initialize
    #cadastre uma id de library e a instancia referenciada   
    @r = Requestor.new 
  end

  #cada método deve simplesmente traduzir de chamadas normais para chamadas
  #do requestor

  def add_book(book)

    params={} 

    params[:book_name] = book.name
    params[:book_id] = book.id
    params[:http_action] = "post"

    p @r.invoke("library", "add_book", params)
  end

  def add_client(client)

    params={} 
    
    params[:client_id] = client.id
    params[:client_name] = client.name
    params[:http_action] = "post"

    p @r.invoke("library", "add_client", params)
  end

  def rent_book(client, book)

    params={} 

    params[:book_id]=book.id
    params[:client_id]=client.id
    params[:http_action] = "post"

    p @r.invoke("library", "rent_book", params)
  end

  def return_book(client, book)

    params={} 

    params[:book_id]=book.id
    params[:client_id]=client.id
    params[:http_action] = "post"

    p @r.invoke("library", "return_book", params)
  end

end

def test
  book= Book.new("1", "Chapeuzinho Vermelho")

  client= Client.new("1", "Igor")

  lib = LibraryProxy.new

  lib.add_client client
  lib.add_book book
  lib.rent_book client, book
  lib.return_book client, book
end

test