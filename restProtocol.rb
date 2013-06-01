require 'rest_client'
require 'cgi'

require_relative 'invocation'

module InvocationHash
  def remote_object_url
    self[:endpoint] + self[:url]
  end

  def rest_url(case_pattern = :camel_case)
    if case_pattern == :capitalize_words
      method = capitalize_words(self[:method])
    elsif case_pattern == :camel_case
      method = camel_words(self[:method])
    else
      method = self[:method]
    end

    remote_object_url + "/" + method
  end

  def capitalize_words(str)
    str.split("_").map(&:capitalize).join
  end

  def camel_words(str)
    str.split(/([A-Z][a-z]+)/).map(&:downcase).delete_if { |a| not a.empty? }.join("_")
  end

  def wsdl
    remote_object_url + '?wsdl'
  end
end

Hash.send(:include, InvocationHash)

class RestProtocol
  def send_message(invocation)
    resource = RestClient::Resource.new invocation.rest_url(invocation[:case_pattern])

    return resource.send(invocation[:http_action], invocation[:params])
  end
end

def test
  r = RestProtocol.new

  invocation = {
    endpoint: "http://www.webservicex.com",
    http_action: "post",
    url: "/globalweather.asmx",
    method: "get_weather",
    case_pattern: :capitalize_words,
    params: {
      "CityName" => "Natal",
      "CountryName" => "Brazil"
    }
  }

  puts invocation.rest_url

  puts r.send_message(invocation)
end

test