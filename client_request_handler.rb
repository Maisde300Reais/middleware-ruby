require 'singleton'

require_relative 'soapProtocol'
require_relative 'restProtocol'
require_relative 'attr_teste'

class Client_Request_Handler
  include Singleton

  attr_reader :message_protocol
  lazy_load :soap_protocol
  lazy_load :rest_protocol

  def set_protocol(message_protocol)
    @message_protocol = message_protocol
  end

  def send_message(invocation)
    CGI.unescapeHTML send("send_as_" + invocation[:protocol].to_s, invocation)
  end

  def send_as_rest(invocation)
    rest_protocol.send_message(invocation)
  end

  def send_as_soap(invocation)
    soap_protocol.send_message(invocation)
  end
end
