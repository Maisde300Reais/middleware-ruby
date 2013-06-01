require 'webrick'  
require 'time'

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
    register_paths

    http_methods = ["GET", "PUT", "POST", "DELETE"]

    http_methods.each do |method|
      Router.class_eval <<-EOMETHDEF
        def do_#{method}(*args)
          request = args[0]
          response = args[1]

          if @routes[request.path]
            if @routes[request.path]["#{method}"]
              message = Marshaller.demarshall(request)

              response.status = 200
              response['Content-Type'] = "text/html"
              response.body = Invoker.invoke(message)

              return
            end
          end

          response.status = 404
          response['Content-Type'] = "text/html"
          response.body = "Not found"
        end
      EOMETHDEF
    end

    print_routes
  end

  def print_routes
    puts @routes
  end 
end

if $0 == __FILE__ then
  srh = ServerRequestHandler.new
  srh.start
end
