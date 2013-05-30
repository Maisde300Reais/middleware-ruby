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

    register_paths

    trap("INT"){ @server.shutdown }

    @server.start
  end

  def register_paths
    File.open("config/routes.config", "r").each(sep="\n") do |file|
      puts file
    end
  end

  def do_GET(request, response)
    puts request.inspect
    puts response.inspect
  end

  def do_POST(request, response)
    puts request.inspect
    puts response.inspect
  end
end

class Router < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    puts request.inspect
    puts response.inspect
  end

  def do_POST(request, response)
    puts request.inspect
    puts response.inspect
  end
end

if $0 == __FILE__ then
  srh = ServerRequestHandler.new
  srh.start
  srh.listen
end