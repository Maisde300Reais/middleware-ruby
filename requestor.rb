require 'singleton'

require_relative 'client_request_handler'
# require_relative 'invocation'
# require_relative 'config'
# require_relative 'qos_observer'
# require_relative 'extension_contexters'
require_relative 'middleware'
require_relative 'Leaseable'
require_relative 'library'

class Requestor
  include Singleton

  def initialize
    # @c = ConfigClass.instance
    @client_request_handler = Client_Request_Handler.instance
    # @client_request_handler.set_protocol @c.protocol
    # @extension_contexters = Extension_Contexters.instance
    # @qos_observer = Quality_of_Service_Observer.instance

    mid = Middleware.instance
    mid.register_lookup "http://localhost:2000/routes"
    mid.register_remote_object "library", Library.new

    mid.load_routes
  end

  def invoke(obj, method, params = {})
    http_method, url = Middleware.instance.objects_to_routes[obj + "#" + method].split(" ")

    invocation = {
      endpoint: "http://localhost:8000",
      http_action: http_method.downcase,
      method: method,
      url: url,
      protocol: :rest,
      case_pattern: :camel_words,
      params: params
    }

    @client_request_handler.send_message(invocation)
  end

end

def test
  r = Requestor.instance
  p r.invoke("library", "add_book", {nome: "GIBE B00K PL0X"})
end

test
