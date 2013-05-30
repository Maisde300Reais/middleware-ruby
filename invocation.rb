class Invocation
  attr_accessor :method, :params

  @params={}

  def initialize(method="", params="")
    @method = method
    @params = params
  end

  def add_param (param_name, param)
    @params[param_name]= param
  end
end