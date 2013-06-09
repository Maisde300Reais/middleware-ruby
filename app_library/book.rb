class Book

  attr_accessor :id, :name, :status

  def initialize(id, title)
    @id = id
    @name =title
    @status= :available
  end

end
