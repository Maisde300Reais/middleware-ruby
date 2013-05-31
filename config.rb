require 'singleton'

require_relative 'soapProtocol'
require_relative 'restProtocol'

class ConfigClass
  include Singleton

  attr_accessor :endpoint, :protocol

  def initialize(endpoint="http://www.webservicex.net/globalweather.asmx?WSDL", protocol= SoapProtocol.new)
    @endpoint = endpoint
    @protocol = protocol
  end

end

def test
  c = ConfigClass.instance
  puts c.endpoint
  puts c.protocol
end
