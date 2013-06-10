class Product
  attr_accessor :name, :id, :price

  def initialize(id, name, price)
    @name = name
    @id = id
    @price = price
  end
end