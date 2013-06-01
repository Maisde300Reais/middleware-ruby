require 'savon'

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

  def soap_action(case_pattern = :camel_case)
    if case_pattern == :capitalize_words
      self[:method] = capitalize_words(self[:method])
    elsif case_pattern == :camel_case
      self[:method] = camel_words(self[:method])
    else
      self[:method] = self[:method]
    end
  end

  def capitalize_words(str)
    str.split("_").map(&:capitalize).join
  end

  def camel_words(str)
    str.split(/([A-Z][a-z]+)/).map(&:downcase).delete_if { |a| a.empty? }.join("_")
  end

  def wsdl
    remote_object_url + '?wsdl'
  end
end

Hash.send(:include, InvocationHash)

class SoapProtocol

  def send_message(invocation)
    invocation.soap_action

    client = Savon.client(wsdl: invocation.wsdl)

    return client.call(:"#{invocation[:method]}", message: invocation[:params])
  end

  def get_operations(endpoint)
    client = Savon.client(wsdl: endpoint)
    client.operations
  end
end

def test
  sp = SoapProtocol.new

  invocation = {
    endpoint: "http://www.webservicex.com",
    http_action: "post",
    url: "/globalweather.asmx",
    method: "GetWeather",
    case_pattern: :camel_words,
    params: {
      "CityName" => "Natal",
      "CountryName" => "Brazil"
    }
  }

  puts sp.send_message invocation
end

test