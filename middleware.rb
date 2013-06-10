require 'open-uri'
require 'singleton'

require_relative 'Lease_monitor'
require_relative 'Leaseable'
require_relative 'default_invoker'
require_relative 'Marshaller'
require_relative 'attr_teste'

require 'net/http'
require 'uri'

class Middleware
  include Singleton

  #identification
  attr_reader :lookup_addresses, :lookup_file_path

  def initialize
    @lookup_addresses = []
    @lookup_file_path = "./client/config/routes.config"
    @invokers = {"default" => DefaultInvoker.new}

    @remote_objects = {}

    add_to_lease_monitor(:objects_to_routes, {})
    add_to_lease_monitor(:routes_to_objects, {})
  end

  def load_objs_to_routes
    load_routes
  end

  def load_routes_to_objs
    load_routes
  end

  ##############IDENTIFICATION##############
  def register_lookup(address)
    lookup_addresses << address
  end

  def get_server(id)
    addrs = @lookup_addresses.cycle

    addrs.each do |addr|
      begin
        str = Net::HTTP.get(URI.parse("http://#{addr}/objects/get_server?id=#{id}"))

        next if str.empty?

        return str[1..-2] if (str.start_with?('"') and str.end_with?('"'))

        return str
      rescue 
        next
      end
    end
  end

  def register_invoker(invoker_id, invoker)
    @invokers[invoker_id] = invoker
  end

  def register_remote_object(id, obj)
    lookup_addresses.each do |addr|
      postData = Net::HTTP.post_form(URI.parse("http://#{addr}/objects/add"),
       {'id'=> id, 'endpoint' => "localhost:8000"})

      puts postData.body
    end

    @remote_objects[id] = obj
  end

  def load_routes
    _get_and_load_routes
  end

  def _get_and_load_routes
    addrs = @lookup_addresses.cycle
    count = 0

    addrs.each do |adr|
      begin
        puts "Trying to load routes file from: " + adr

        open(adr) do |src|
          open(@lookup_file_path, "wb") do |dst|
            dst.write(src.read)
          end
        end

        _load_routes_file

        puts "Routes file loaded from: " + adr

        return true
      rescue 
        puts "Failed to load routes from: " + adr
        count = (count + 1) % @lookup_addresses.length
        sleep(1) if count == 0
        next
      end
    end
  end

  def _load_routes_file
    File.open(@lookup_file_path, "r").each(sep="\n") do |line|
      next if line.empty? or line.start_with?("#")

      http_method, url, remote_method = line.split(" ")

      routes_to_objects[url] ||= {}
      routes_to_objects[url][http_method] = remote_method
      objects_to_routes[remote_method] = http_method + " " + url
    end
  end

  def get_invoker(id = "default")
    @invokers[id]
  end

  def get_remote_object(id)
    @remote_objects[id]
  end

  ##############LIFECYCLE##############
  def add_to_lease_monitor(key, obj)
    obj.send(:extend, Leaseable)

    LeaseMonitor.instance.add_to_monitor(key, obj)

    LeaseMonitor.instance.start_verify_leases if LeaseMonitor.instance.num_objects >= 1

    obj.start_lease(3000)
  end

  def method_missing(m, *args, &block)
    LeaseMonitor.instance.send(:[], m.to_sym)
  end
end

=begin
mid = Middleware.instance
mid.register_lookup("http://localhost:2000")
mid.register_lookup("http://localhost:8000/routes")
if mid.load_routes
  puts mid.routes_to_objects
  puts mid.objects_to_routes
end
=end