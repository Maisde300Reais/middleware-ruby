require 'webrick'  
require 'time'

require_relative 'middleware'

class ServerRequestHandler
  include WEBrick

  def initialize
  end

  def start
    root = File.expand_path '~/public_html'
    @server = WEBrick::HTTPServer.new(:Port => 8000)
    
    @server.mount "/routes", WEBrick::HTTPServlet::FileHandler, './server/config/routes.config'
    @server.mount "/", Router

    trap("INT"){ @server.shutdown }

    @server.start
  end
end

class Router < WEBrick::HTTPServlet::AbstractServlet

  def initialize(server)
    super(server)

    http_methods = ["GET", "PUT", "POST", "DELETE"]

    http_methods.each do |method|
      Router.class_eval <<-EOMETHDEF
        def do_#{method}(*args)
          middleware = Middleware.instance

          request = args[0]
          response = args[1]

          if middleware.routes_to_objects[request.path]
            if middleware.routes_to_objects[request.path]["#{method}"]
              message = Marshaller.demarshall(request)

              response.status = 200
              response['Content-Type'] = "text/json"
              response.body = handle_message(message)

              return
            end
          end

          response.status = 404
          response['Content-Type'] = "text/json"
          response.body = "{ message: Not found }"
        end
      EOMETHDEF
    end
  end

  def handle_message(message)
    if message[:invoker_id]
      invoker = Middleware.instance.getInvoker(message[:invoker_id])
    else
      invoker = Middleware.instance.getInvoker #default invoker
    end

    invoker.invoke(message)
  end
end

if $0 == __FILE__ then
  srh = ServerRequestHandler.new
  srh.start
end
