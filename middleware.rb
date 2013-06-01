require 'open-uri'
require 'singleton'

class Middleware
  include Singleton
  attr_accessor :lookup_addresses, :lookup_file_path
  attr_reader :routes

  def initialize
    @lookup_addresses = []
    @routes = {}
    @lookup_file_path = "./client/config/routes.config"
  end

  def register_lookup(address)
    lookup_addresses << address
  end

  def get_routes_file
    open(@lookup_addresses.first) do |src|
      open(@lookup_file_path, "wb") do |dst|
        dst.write(src.read)

        return true
      end
    end

  rescue
    @lookup_addresses.shift

    return false if @lookup_addresses.empty?

    get_routes_file
  end

  def load_routes_file
    File.open(@lookup_file_path, "r").each(sep="\n") do |line|
      next if line.empty? or line.start_with?("#")

      http_method, url, remote_method = line.split

      @routes[url] ||= {}
      @routes[url][http_method] = remote_method
    end
  end
end

mid = Middleware.new
mid.register_lookup("http://localhost:8000/routes")
mid.get_routes_file
mid.load_routes_file
puts mid.routes