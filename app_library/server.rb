require_relative "../basic_remote/server_request_handler"
require_relative "library"

if $0 == __FILE__ then
  srh = ServerRequestHandler.new
  srh.start "library", Library.new #passem o nome da instancia e a classe que representa
end