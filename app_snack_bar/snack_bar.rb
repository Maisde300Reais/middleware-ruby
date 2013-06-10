require_relative 'food'
require_relative 'order'

class SnackBar 
  attr_accessor :food

  def initialize
    @food_list={}
    @orders=[]
  end

  def add_food(params)
    food = Food.new(params["food_id"], params["food_name"])
    @food_list[food.id]=food
    return "> Comida " + @food_list[food.id].name + " cadastrada com sucesso!"
  end

  def set_order(params)
    order= Order.new(params["quantity"], params["food"], params["address"])
    @orders << order
    return "> Pedido de #{order.quantity} #{order.food}(s) sera entregue em #{order.address}"
  end

end


def teste

 sn = SnackBar.new

 params={}
 params["food_id"]= "1"
 params["food_name"] = "Coxinha"

 puts sn.add_food params

 params["quantity"] = 5
 params["food"] = "Coxinha"
 params["address"] = "dimap"

 puts sn.set_order params

end
