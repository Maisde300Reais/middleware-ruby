require_relative '../basic_remote/server_request_handler'
require_relative 'library'


ServerRequestHandler.new(ARGV[0]).start("library", Library)