require_relative '../basic_remote/server_request_handler'


ServerRequestHandler.new(ARGV[0]).start("store", Store)