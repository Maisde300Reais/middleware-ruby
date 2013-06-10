require_relative '../server_request_handler'
require_relative 'academy'

if $0 == __FILE__ then
	srh = ServerRequestHandler.new
	srh.start "academy", Academy.new	# passar o nome da instancia e a classe que representa
end