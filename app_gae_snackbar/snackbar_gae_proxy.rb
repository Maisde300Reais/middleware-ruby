require_relative '../basic_remote/requestor'
require_relative 'food'

class SnackBarProxy

  def initialize
    @r = Requestor.instance
  end

  def add_food(food, quantity)

    params={} 

    params[:http_action] = "post"
    params[:request] = "add"
    params[:food_name] = food.name
    params[:quantity] = quantity

    p @r.invoke("roger-pd-app", "snackbar", params)
  end

  def sell_food(food, quantity)

    params={} 

    params[:http_action] = "post"
    params[:request] = "buy"
    params[:food_name] = food.name
    params[:quantity] = quantity

    p @r.invoke("roger-pd-app", "snackbar", params)
  end

  def delete_all()
    params={} 
    params[:http_action] = "put"
    p @r.invoke("roger-pd-app", "snackbar", params)
  end

end

def teste
  food = Food.new("Coxinha", 5)
  food2 = Food.new("Risole", 10)
  food3 = Food.new("Folheado", 20)

  l = SnackBarProxy.new
  #l.delete_all()
  #l.add_food(food, 10)

  l.sell_food(food, 1)

end

teste