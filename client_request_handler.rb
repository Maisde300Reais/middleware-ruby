require 'singleton'
require_relative 'soapProtocol'

class Client_Request_Handler
  include Singleton

  attr_reader :message_protocol

  def set_protocol(message_protocol)
    @message_protocol = message_protocol
  end

  def send_message(endpoint, invocation)
    message_protocol.send_message(endpoint, invocation)
  end

end


def test
  c = Client_Request_Handler.instance

  soap = SoapProtocol.new
  c.set_protocol(soap)

  invocation = Invocation.new("get_weather", {"CityName"=>"Natal", "CountryName"=> "Brazil"})

  endpoint = "http://www.webservicex.net/globalweather.asmx?WSDL"

  puts c.send_message(endpoint, invocation)
end

