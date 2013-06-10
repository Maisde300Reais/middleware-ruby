require_relative "../basic_remote/server_request_handler"
require_relative 'academy'

ServerRequestHandler.new(ARGV[0]).start("academy", Academy)