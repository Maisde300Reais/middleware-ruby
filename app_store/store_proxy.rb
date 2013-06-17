require_relative '../basic_remote/requestor'
require_relative 'product'
require_relative 'user'

class StoreProxy

  def initialize
    @r = Requestor.instance
  end

  def add_product(product)
    params = {}

    params[:product_id] = product.id
    params[:product_name] = product.name
    params[:product_price] = product.price
    params[:http_action] = "post"

    puts @r.invoke("store", "add_product", params)
  end

  def add_user(user)
    params = {}

    params[:user_login] = user.login
    params[:user_password] = user.password
    params[:http_action] = "post"

    puts @r.invoke("store", "add_user", params)
  end

  def get_all
    params = {}
    params[:http_action] = "get"

    puts @r.invoke("store", "get_all", params)
  end
end

def teste
  proxy = StoreProxy.new

  proxy.add_user(User.new("usuario", "senha"))
  proxy.add_user(User.new("usuario2", "senha"))
  proxy.add_product(Product.new(10, "produto", 1300))
end

teste