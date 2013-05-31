require 'savon'

require_relative 'invocation'

class SoapProtocol

  def send_message(endpoint, invocation)

    client = Savon.client(wsdl: endpoint)

    response = client.call(:"#{invocation.method}", message: invocation.params)

  end

  def get_operations(endpoint)

    client = Savon.client(wsdl: endpoint)
    client.operations
  
  end

end

def test
  sp = SoapProtocol.new

  invocation = Invocation.new("get_weather", {"CityName"=>"Natal", "CountryName"=> "Brazil"})


  puts  invocation.method
  puts sp.send_message "http://www.webservicex.net/globalweather.asmx?WSDL", invocation

end