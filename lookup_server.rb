require 'webrick'  
require 'cgi'
require 'fileutils'
require 'tempfile'

require_relative 'utils'

class LookupServer
  def start
    @server = WEBrick::HTTPServer.new(:Port => 2000)
    @server.mount "/routes", RouteManager
    trap("INT"){ @server.shutdown }
    @server.start
  end

end

class RouteManager < WEBrick::HTTPServlet::AbstractServlet
  def initialize(server)
    super(server)
    @filename = "./Lookup/config/routes.config"
  end

  def register_route(http_method, url, remote_object)
    File.open(@filename, 'a') do |file|
      file.puts http_method + " " + url + " " + remote_object
    end

    return 200, "OK"
  rescue 
    return 500, "Houve um erro ao tratar os dados"
  end

  def delete_route(http_method, url, remote_object)
    tmp = Tempfile.new("extract")
    open(@filename, 'r').each { 
      |l| tmp << l unless l.chomp == http_method + " " + url + " " + remote_object 
    }
    tmp.close

    FileUtils.mv(tmp.path, @filename)

    return 200, "OK"
  rescue 
    return 500, "Houve um erro ao tratar os dados"
  end

  def do_GET(request, response)
    response.status = 200
    response['Content-Type'] = "text/plain"
    response.body = IO.read(@filename)  
  end

  def do_POST(request, response)
    params = Utils.decode_params_url(request.body)

    status, body = register_route(params["http_method"], params["url"], params["remote_object"])

    response.status = status
    response['Content-Type'] = "text/html"
    response.body = body
  end

  def do_DELETE(request, response)
    params = decode_params_url(request.body)

    status, body = delete_route(params["http_method"], params["url"], params["remote_object"])

    response.status = status
    response['Content-Type'] = "text/html"
    response.body = body
  end
end

server = LookupServer.new
server.start