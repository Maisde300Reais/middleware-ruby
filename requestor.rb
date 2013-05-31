require 'singleton'

require_relative 'client_request_handler'
require_relative 'invocation'
require_relative 'config'
require_relative 'qos_observer'
require_relative 'extension_contexters'

class Requestor

  include Singleton

  def initialize
    @c = ConfigClass.instance
    @client_request_handler = Client_Request_Handler.instance
    @client_request_handler.set_protocol @c.protocol
    @extension_contexters = Extension_Contexters.instance
    @qos_observer = Quality_of_Service_Observer.instance
  end

  def invoke(method, params)

    invocation = Invocation.new(method, params)

    @extension_contexters.set_context(invocation)

    @qos_observer.set_start(invocation)

    @client_request_handler.send_message(@c.endpoint, invocation)

  end

end

def test
  
  r = Requestor.instance

  puts r.invoke("get_weather", {"CityName"=>"Natal", "CountryName"=> "Brazil"})

end