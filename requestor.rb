require 'singleton'

require_relative 'client_request_handler'
# require_relative 'invocation'
# require_relative 'config'
# require_relative 'qos_observer'
# require_relative 'extension_contexters'
require_relative 'middleware'
require_relative 'leaseable'

class AuthInterceptor
  include Singleton

  attr_accessor :login, :password

  def before_invocation(invocation)
    if @login.nil? or @password.nil?
      puts "Digite login e senha:"
      invocation[:params][:login] = gets.chomp!
      invocation[:params][:password] = gets.chomp!

      @login = invocation[:params][:login]
      @password = invocation[:params][:password]
    else
      invocation[:params][:login] = @login
      invocation[:params][:password] = @password
    end
  end

  def after_invocation(invocation)
  end
end

class ReplicationInterceptor
  include Singleton

  attr_accessor :login, :password

  def before_invocation(invocation)
  end

  def after_invocation(invocation)
    servers = Middleware.instance.get_servers invocation[:remote_object]

    servers.each do |server|
      next if Middleware.instance.port == server

      invocation[:endpoint] = "http://#{server}"

      Client_Request_Handler.instance.send_message(invocation)
    end
  end
end

class Requestor
  include Singleton

  def initialize
    # @c = ConfigClass.instance
    @client_request_handler = Client_Request_Handler.instance
    # @client_request_handler.set_protocol @c.protocol

    #Extension Pattern
    # @extension_contexters = Extension_Contexters.instance

    #Extended Infraestructure Pattern
    # @qos_observer = Quality_of_Service_Observer.instance
    @invocation_intercepters = []

    @invocation_intercepters << AuthInterceptor
    @invocation_intercepters << ReplicationInterceptor

    mid = Middleware.instance
    mid.register_lookup "localhost:2000"
  end

  def invoke(obj, method, params = {})
    endpoint = "http://#{(Middleware.instance.get_server obj)}"

    invocation = {
      remote_object: obj,
      endpoint: endpoint,
      method: method,
      http_action: params[:http_action],
      url: "/#{obj}/#{method}",
      protocol: :rest,
      case_pattern: :camel_words,
      params: params
    }

    @invocation_intercepters.each do |inter|
      inter.instance.before_invocation(invocation)
    end

    result = @client_request_handler.send_message(invocation)

    @invocation_intercepters.each do |inter|
      inter.instance.after_invocation(invocation)
    end

    return result
  end

end