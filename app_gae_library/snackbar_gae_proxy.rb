require_relative '../basic_remote/requestor'
require_relative 'food'

class SnackBarProxy

  def initialize
    @r = Requestor.instance
  end

  def add_food(food)

    params={} 

    params[:http_action] = "post"
    params[:name]= food.name
    params[:qtd]= food.qtd

    p @r.invoke("roger-pd-app", "snackbar", params)
  end

  def sell_food(book)

    params={} 

    params[:http_action] = "post"
    params[:request] = "buy"
    params[:book] = food.name

    p @r.invoke("roger-pd-app", "snackbar", params)
  end

end