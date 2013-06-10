class User
  attr_accessor :login, :password, :products

  def initialize(login, pw)
    @login = login
    @password = pw
    @products = {}
  end
end