require 'rest_client'
require 'cgi'

require_relative 'invocation'

module InvocationHash
  def remote_object_url
    self[:endpoint] + self[:url]
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
    resource = RestClient::Resource.new invocation.remote_object_url

    return resource.send(invocation[:http_action], invocation[:params])
  end
end