require 'open-uri'
require 'singleton'

require_relative 'Lease_monitor'
require_relative 'Leaseable'

class Middleware
  include Singleton

  #identification
  attr_reader :lookup_addresses, :lookup_file_path, :routes_to_objects,
    :objects_to_routes

  def initialize
    @lookup_addresses = []
    @routes_to_objects = {}
    @objects_to_routes = {}
    @lookup_file_path = "./client/config/routes.config"

    add_to_lease_monitor(@objects_to_routes)
    add_to_lease_monitor(@routes_to_objects)
  end

  ##############IDENTIFICATION##############
  def register_lookup(address)
    lookup_addresses << address
  end

  def load_routes
    _get_routes_file
    _load_routes_file
  end

  def _get_routes_file
    open(@lookup_addresses.first) do |src|
      open(@lookup_file_path, "wb") do |dst|
        dst.write(src.read)
      end
    end

    _load_routes_file

    puts "Routes file loaded from: " + @lookup_addresses.first

    return true
  rescue
    puts "Failed to get routes from " + @lookup_addresses.first

    @lookup_addresses.shift

    return false if @lookup_addresses.empty?

    load_routes
  end

  def _load_routes_file
    File.open(@lookup_file_path, "r").each(sep="\n") do |line|
      next if line.empty? or line.start_with?("#")

      http_method, url, remote_method = line.split

      @routes_to_objects[url] ||= {}
      @routes_to_objects[url][http_method] = remote_method
      @objects_to_routes[remote_method] = http_method + " " + url
    end
  end

  ##############LIFECYCLE##############
  def add_to_lease_monitor(obj)
    obj.send(:extend, Leaseable)

    LeaseMonitor.instance.add_to_monitor(obj)

    LeaseMonitor.instance.start_verify_leases if LeaseMonitor.instance.num_objects >= 1

    obj.start_lease(10)
  end
end

mid = Middleware.instance
mid.register_lookup("http://localhost:2000")
mid.register_lookup("http://localhost:8000/routes")
if mid.load_routes
  puts mid.routes_to_objects
  puts mid.objects_to_routes
end