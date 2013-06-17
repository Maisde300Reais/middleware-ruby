require_relative '../basic_remote/requestor'
require_relative 'snack_bar'
require_relative 'order'
require_relative 'food'

class Snackbar_proxy

  def initialize 
    @r = Requestor.instance
  end

  def add_food(food)

    params={} 

    params[:food_id]= food.id
    params[:food_name]=food.name
    params[:http_action] = "post"

    p @r.invoke("snack_bar", "add_food", params)
  end

  def set_order(order)

    params={} 

    params[:quantity]= order.quantity
    params[:food]=order.food
    params[:address]=order.address
    params[:http_action] = "post"
    
    p @r.invoke("snack_bar", "set_order", params)
  end

end