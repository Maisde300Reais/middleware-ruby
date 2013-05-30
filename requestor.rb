require 'singleton'

require_relative 'client_request_handler'
require_relative 'invocation'
require_relative 'config'

class Requestor

  include Singleton

  def initialize
    @c = ConfigClass.instance
    @client_request_handler = Client_Request_Handler.instance
    @client_request_handler.set_protocol @c.protocol
  end

  def invoke(method, params)

    invocation = Invocation.new(method, params)

    @client_request_handler.send_message(@c.endpoint, invocation)

  end

end

def test

  r = Requestor.instance

  puts r.invoke("get_weather", {"CityName"=>"Natal", "CountryName"=> "Brazil"})


end
