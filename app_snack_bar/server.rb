require_relative '../basic_remote/server_request_handler'
require_relative 'snack_bar'


ServerRequestHandler.new(ARGV[0]).start("snack_bar", SnackBar)