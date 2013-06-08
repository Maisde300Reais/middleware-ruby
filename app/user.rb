class User

  attr_accessor :id, :name, :rented_books

  def initialize(id, name)
    @id= id
    @name = name
    @rented_books={}
  end

  
end