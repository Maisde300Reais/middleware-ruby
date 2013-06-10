require_relative 'product'

class Sell
  attr_accessor :product, :qtd

  def initialize (product, qtd)
    @product=product
    @qtd=qtd
  end
end