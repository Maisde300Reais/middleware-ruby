require_relative 'food'

class Order

  attr_accessor :quantity, :food, :address

  def initialize(quantity, food, address)
    @quantity= quantity
    @food = food
    @address = address
  end  

end
