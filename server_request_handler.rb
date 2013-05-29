require 'webrick'  
require 'time'

class ServerRequestHandler 
  include WEBrick

  def start
    root = File.expand_path '~/public_html'
    @server = WEBrick::HTTPServer.new(:Port => 8000)
    
    @server.mount "/questions", eval("WebForm")

    trap("INT"){ @server.shutdown }

    @server.start
  end

  def listen
  end

  def handle_request(client)

    Thread.new do

      line = client.gets

      puts line

      resp = "<html>#{Time.now.httpdate()}</html>"

      headers = ["HTTP/1.1 200 OK",
                 "Date: #{Time.now.httpdate()}",
                 "Server: Ruby",
                 "Content-Type: text/html; charset=iso-8859-1",
                 "Content-Length: #{resp.length}\r\n\r\n"].join("\r\n")

      puts "========================"

      client.puts headers

      client.puts resp

      client.close
    end
  end
end

class WebForm < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    status, content_type, body = print_questions(request)

    response.status = status
    response['Content-Type'] = content_type
    response.body = body
  end

  def print_questions(request)
    html = "<h1>uehuehuehueheuheueh</h1>"
    return 200, "text/html", html
  end
end



if $0 == __FILE__ then

  srh = ServerRequestHandler.new
  srh.start
  srh.listen

end