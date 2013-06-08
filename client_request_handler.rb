require 'singleton'

require_relative 'soapProtocol'
require_relative 'restProtocol'

class Class
   def lazy_load(*args)
      args.each do |var|       
        define_method var do
          if self.instance_variable_get("@#{var}".to_sym).nil?
            self.instance_variable_set("@#{var}".to_sym, send("load_#{var}")) 
          end

          self.instance_variable_get("@#{var}".to_sym)
        end
      end
   end
end

class Client_Request_Handler
  include Singleton

  attr_reader :message_protocol
  lazy_load :soap_protocol, :rest_protocol

  def set_protocol(message_protocol)
    @message_protocol = message_protocol
  end

  def send_message(invocation)
    CGI.unescapeHTML send("send_as_" + invocation[:protocol].to_s, invocation)
  end

  def load_soap_protocol
    SoapProtocol.new
  end

  def load_rest_protocol
    RestProtocol.new
  end

  def send_as_rest(invocation)
    rest_protocol.send_message(invocation)
  end

  def send_as_soap(invocation)
    soap_protocol.send_message(invocation)
  end
end
