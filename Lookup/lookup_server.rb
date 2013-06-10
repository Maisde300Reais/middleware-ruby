require 'webrick'  
require 'cgi'
require 'fileutils'
require 'tempfile'
require 'json'
require 'set'

require_relative '../utils'

class Lookup
  include Singleton

  def initialize
    @remote_objects = {}
  end

  def register_remote_object(id, endpoint)
    @remote_objects[id] ||= Set.new
    @remote_objects[id] << endpoint

    return 200, "Object #{id} registered at endpoint #{endpoint}"
  end

  def get_all_info
    return 200, @remote_objects.to_json
  end

  def servers_by_remote_object(id)
    return 404, "There is no server which has a object with this id: #{id}" unless @remote_objects[id]
    return 200, @remote_objects[id].to_a.to_json
  end

  def get_server(id)
    return 404, "There is no server which has a object with this id: #{id}" unless @remote_objects[id]
    return 200, @remote_objects[id].to_a.sample.to_json
  end
end

class LookupServer
  def start
    @server = WEBrick::HTTPServer.new(:Port => 2000)
    @server.mount "/objects", LookupHandler

    trap("INT"){ @server.shutdown }
    @server.start
  end
end

class LookupHandler < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    if request.path == "/objects/all"
      status, body = Lookup.instance.get_all_info
    elsif request.path == "/objects/get_server"
      status, body = Lookup.instance.get_server(request.query["id"])
    elsif request.path == "/objects/get_servers"
      status, body = Lookup.instance.servers_by_remote_object(request.query["id"])
    end

    response.status = status
    response['Content-Type'] = "text/html"
    response.body = body
  end

  def do_POST(request, response)
    if request.path == "/objects/add"
      hash = Utils.decode_params_url(request.body)
      status, body = Lookup.instance.register_remote_object(hash["id"], hash["endpoint"])
    end

    response.status = status
    response['Content-Type'] = "text/html"
    response.body = body
  end
end


=begin
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
=end

server = LookupServer.new
server.start