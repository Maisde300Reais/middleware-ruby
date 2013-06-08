require_relative 'library'
require_relative 'book'
require_relative 'user'

class Server 

  def initialize
    @library=Library.new
  end

  def get_all_books

  end

  def get_all_users

  end

  def add_book(params)
    book= Book.new(params[:id], params[:title])
    @library.add_book(book)
  end

  def add_user(params)
    user= User.new(params[:id], params[:name])
    @library.add_book(book)
  end

  def rent_book(params)
    @library.rent_book(params[:client_id], params[:book_id])
  end

  def return_book(params)
  end


end