require 'webrick'  
require 'time'

class ServerRequestHandler
  include WEBrick

  def initialize
  end

  def start
    root = File.expand_path '~/public_html'
    @server = WEBrick::HTTPServer.new(:Port => 8000)
    
    @server.mount "/", Router

    trap("INT"){ @server.shutdown }

    @server.start
  end
end

class Router < WEBrick::HTTPServlet::AbstractServlet

  def initialize(server)
    super(server)
    @routes = {}
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

  def register_paths
    File.open("config/routes.config", "r").each(sep="\n") do |line|
      http_method, url, remote_method = line.split

      @routes[url] ||= {}
      @routes[url][http_method] = remote_method
    end
  end

  def print_routes
    puts @routes
  end 
end

if $0 == __FILE__ then
  srh = ServerRequestHandler.new
  srh.start
end
