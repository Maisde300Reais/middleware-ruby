require '../requestor'
require 'snack_bar'
require 'order'
require 'food'

class Snackbar_proxy

  def initialize 
    @r = Requestor.new("snack_bar", Snackbar.new)
  end

  def add_food(food)

    params={} 

    params[:food_id]= food.id
    params[:food_name]=food.name

    p @r.invoke("snack_bar", "add_food", params)
  end

  def set_order(order)

    params={} 

    params[:quantity]= order.quantity
    params[:food]=order.food
    params[:address]=order.address
    
    p @r.invoke("snack_bar", "set_order", params)
  end

end