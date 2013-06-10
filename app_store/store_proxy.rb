require_relative '../requestor'
require_relative 'store'
require_relative 'sell'
require_relative 'product'

class StoreProxy

  def initialize
    @r = Requestor.new
  end

  def list_sells
    params={}

    p @r.invoke("store", "list_sells", params)
  end

  def add_product(product)
    params={}

    params[:name]= product.name
    params[:product_id]= product.id

    p @r.invoke("store", "add_product", params)
  end

  def add_sell(sell)
    params={}

    params[:qtd]= product.qtd
    params[:product_id]= product.id

    p @r.invoke("store", "add_sell", params)
  end

end