require 'savon'

require_relative 'Invocation'

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

sp = SoapProtocol.new

invocation = Invocation.new

invocation.add_param "CityName", "Natal"
invocation.add_param "CountryName", "Brazil"

invocation.method = "get_weather"

puts sp.send_message "http://www.webservicex.net/globalweather.asmx?WSDL", invocation