require 'singleton'

require_relative 'client_request_handler'
require_relative 'invocation'
require_relative 'config'
require_relative 'qos_observer'
require_relative 'extension_contexters'
require_relative 'middleware'

class Requestor
  include Singleton

  def initialize
    @c = ConfigClass.instance
    @client_request_handler = Client_Request_Handler.instance
    @client_request_handler.set_protocol @c.protocol
    @extension_contexters = Extension_Contexters.instance
    @qos_observer = Quality_of_Service_Observer.instance
    @routes_cache = {}
  end

  def invoke(obj, method, params)
    

    @client_request_handler.send_message(@c.endpoint, invocation)
  end

end

def test
  
  r = Requestor.instance

  puts r.invoke("library", "get_potato")

end