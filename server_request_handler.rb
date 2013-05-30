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

    #Router.get_instance(@server).print_routes

    trap("INT"){ @server.shutdown }

    @server.start
  end
end

class Router < WEBrick::HTTPServlet::AbstractServlet

  def initialize(server)
    super(server)
    @routes = {}

    register_paths
    print_routes
  end

  def register_paths
    File.open("config/routes.config", "r").each(sep="\n") do |line|
      http_method, url, remote_method = line.split

      @routes[url] = [http_method, remote_method]
    end
  end

  def print_routes
    puts @routes
  end

  def do_GET(request, response)
    puts request.inspect
    puts response.inspect
        puts @routes

  end

  def do_POST(request, response)
    puts request.inspect
    puts response.inspect
        puts @routes

  end
end

if $0 == __FILE__ then
  srh = ServerRequestHandler.new
  srh.start
  srh.listen
end
