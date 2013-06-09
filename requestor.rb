require 'singleton'

require_relative 'client_request_handler'
# require_relative 'invocation'
# require_relative 'config'
# require_relative 'qos_observer'
# require_relative 'extension_contexters'
require_relative 'middleware'
require_relative 'Leaseable'

class Requestor

  def initialize
    # @c = ConfigClass.instance
    @client_request_handler = Client_Request_Handler.instance
    # @client_request_handler.set_protocol @c.protocol

    #Extension Pattern
    # @extension_contexters = Extension_Contexters.instance

    #Extended Infraestructure Pattern
    # @qos_observer = Quality_of_Service_Observer.instance

    mid = Middleware.instance
    mid.register_lookup "localhost:2000"
  end

  def invoke(obj, method, params = {})
    endpoint = "http://#{(Middleware.instance.get_server "library")}"

    #http_method, url = Middleware.instance.objects_to_routes[obj + "#" + method].split(" ")

    invocation = {
      endpoint: endpoint,
      http_action: "post",
      method: method,
      url: "/#{obj}/#{method}",
      protocol: :rest,
      case_pattern: :camel_words,
      params: params
    }

    puts invocation

    @client_request_handler.send_message(invocation)
  end

end

r = Requestor.new
p r.invoke("library", "add_book", {book_name: "huehue", book_id: "huhruar"})