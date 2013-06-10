require_relative 'product'
require_relative 'user'

class Store
  attr_accessor :users

  def initialize
    @users={}
  end

  def add_product(params)
    user = auth(params)

    return "> Falha de autenticacao!" unless user

    prod = Product.new(params["product_id"], params["product_name"], params["product_price"])

    user.products[prod.id] = prod

    return "> Produto #{prod.name} de id #{prod.id} cadastrado com sucesso!"
  end

  def add_user(params)
    user = User.new(params["user_login"], params["user_password"])

    return "> Usuario ja existe!" if @users[user.login]

    @users[user.login] = user

    return "> Usuario #{user.login} cadastrado com sucesso!"
  end

  def get_all(params)
    return @users.to_s
  end

  def auth(params)
    return nil if users[params["login"]].nil?
    return users[params["login"]] if users[params["login"]].password == params["password"]
  end
end