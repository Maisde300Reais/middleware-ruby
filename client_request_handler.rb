require 'singleton'

class Client_Request_Handler
  include Singleton

  attr_reader :message_protocol

  def set_protocol(message_protocol)
    @message_protocol = message_protocol
  end

  def send_message(endpoint, invocation)
    message_protocol.send_message(endpoint, invocation)
  end

end
