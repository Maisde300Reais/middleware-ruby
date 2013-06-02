require 'webrick'  
require 'time'
require 'benchmark'

require_relative 'middleware'
require_relative 'library'

class ServerRequestHandler
  include WEBrick

  def initialize
  end

  def start
    root = File.expand_path '~/public_html'
    @server = WEBrick::HTTPServer.new(:Port => 8000)

    @server.mount "/routes", WEBrick::HTTPServlet::FileHandler, './server/config/routes.config'
    @server.mount "/", HttpHandler

    trap("INT"){ @server.shutdown }

    Thread.new {
      mid = Middleware.instance
      mid.register_lookup "http://localhost:8000/routes"
      mid.register_remote_object "library", Library.new

      p Benchmark.measure {
        while not mid.load_routes
          p 'hue'
        end
      }

      puts mid.routes_to_objects
      puts mid.objects_to_routes
    }

    @server.start
  end
end

class HttpHandler < WEBrick::HTTPServlet::AbstractServlet

  def initialize(server)
    super(server)

    http_methods = ["GET", "PUT", "POST", "DELETE"]

    http_methods.each do |method|
      HttpHandler.class_eval <<-EOMETHDEF
        def do_#{method}(*args)
          middleware = Middleware.instance

          request = args[0]
          response = args[1]

          if middleware.routes_to_objects[request.path]
            if middleware.routes_to_objects[request.path]["#{method}"]
              message = Marshaller.demarshall_request(request)

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
      invoker = Middleware.instance.get_invoker(message[:invoker_id])
    else
      invoker = Middleware.instance.get_invoker #default invoker
    end

    invoker.invoke(message).to_s
  end
end

if $0 == __FILE__ then
  srh = ServerRequestHandler.new
  srh.start
end
