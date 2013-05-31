require 'rest_client'

require_relative 'invocation'

class RestProtocol

  def send_message(endpoint, invocation)

    resource = RestClient::Resource.new endpoint

    if invocation.method == "get"
      resource.get
    elsif invocation.method == "post"
      resource.post invocation.params
    elsif invocation.method == "delete"
      resource.delete
    elsif invocation.method == "put"
      resource.put invocation.params
    end

  end


end

def test
  r = RestProtocol.new

  invocation = Invocation.new("post", {"CityName"=>"Natal", "CountryName"=> "Brazil"})

  endpoint = "http://www.webservicex.com/globalweather.asmx/GetWeather"

  puts r.send_message(endpoint, invocation)
end