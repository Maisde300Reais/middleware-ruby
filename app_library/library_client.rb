require_relative 'library_proxy'
require_relative 'client'
require_relative 'book'

book= Book.new("1", "Chapeuzinho Vermelho")

client= Client.new("1", "Igor")

lib = LibraryProxy.new

lib.add_client client
lib.add_book book
lib.rent_book client, book
lib.return_book client, book