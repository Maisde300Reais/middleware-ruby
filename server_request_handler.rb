require 'webrick'  
require 'time'
require 'benchmark'

require_relative 'middleware'
require_relative 'app_library/library'

class ServerRequestHandler
  include WEBrick

  attr_accessor :port

  def initialize(port)
    @port = port
  end

  def start 
    root = File.expand_path '~/public_html'
    @server = WEBrick::HTTPServer.new(:Port => @port)

    @server.mount "/", HttpHandler

    trap("INT"){ @server.shutdown }

    Middleware.instance.register_lookup "localhost:2000"
    Middleware.instance.port = @port
    Middleware.instance.register_remote_object "library", Library.new
    Middleware.instance._load_routes_file

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


ServerRequestHandler.new(ARGV[0]).start