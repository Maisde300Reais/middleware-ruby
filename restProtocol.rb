require 'rest_client'

require_relative 'invocation'

module InvocationHash
  def full_url
    self[:endpoint] + self[:url] + "/" + self[:method]
  end
end

Hash.send(:include, InvocationHash)

class RestProtocol
  def send_message(invocation)
    resource = RestClient::Resource.new invocation.full_url

    resource.send(invocation[:http_action], invocation[:params])
  end
end

def test
  r = RestProtocol.new

  invocation = {
    endpoint: "http://www.webservicex.com",
    http_action: "post",
    url: "/globalweather.asmx",
    method: "GetWeather",
    params: {
      "CityName" => "Natal",
      "CountryName" => "Brazil"
    }
  }

  puts r.send_message(invocation)
end