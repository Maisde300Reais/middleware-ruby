require_relative 'sells'
require_relative 'products'

class Store

  attr_accessor :sells, :products

  def initialize
    @sells=[]
    @products={}
  end

  def list_sells
    result = "Produto | Qtd "

    @sells.each do |sell| 
      result << "#{sell.product.name} | #{sell.qtd}"
    end

    result
  end

  def add_sell(params)
    sell= Sell.new(@products[params["product_id"]], params["qtd"])

    @sells << sell

    return "> Venda de #{sell.product.name} em quantidade sell.qtd feita com sucesso!"
  end

  def add_product(params)
    prod = Product.new(params["product_id"], params["name"])

    @products << prod

    return "> Produto #{prod.name} de id #{prod.id} cadastrado com sucesso!"
  end
end