class Invocation
  attr_accessor :method, :params

  def initialize
    @method=""
    @params = {}
  end

  def add_param (param_name, param)
    @params[param_name]= param
  end
end