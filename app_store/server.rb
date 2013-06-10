require_relative '../basic_remote/server_request_handler'
require_relative 'store'


ServerRequestHandler.new(ARGV[0]).start("store", Store)