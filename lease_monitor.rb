require_relative "leaseable"
require 'singleton'

class LeaseMonitor
  include Singleton

  def initialize
    @monitored_objects = {}
  end

  def [](key)
    @monitored_objects[key]
  end

  def []=(key, obj)
    add_to_monitor(key, obj)
  end

  def lease_expired(obj_key)
    puts "Lease expired: " + @monitored_objects[obj_key].inspect

    result = @monitored_objects[obj_key].lease_expired

    @monitored_objects.delete obj_key if result == :delete
    @monitored_objects[obj_key].renew_lease if result == :renew
  end

  def add_to_monitor(key, obj)
    @monitored_objects[key] = obj
    obj.key = key
  end 

  def start_verify_leases
    Thread.new do
      loop {
        if @monitored_objects.empty?
          Thread.stop
        end

        @monitored_objects.each do |key, obj|
          if obj.expired_lease?
            lease_expired(obj.key)
          end
        end

        sleep(0)
      }
    end
  end

  def num_objects
    @monitored_objects.length
  end
end

=begin
class Foo
  def method_missing(m, *args, &block)
    puts "Chamou metodo #{m} com argumentos #{args}"

    if not block.nil?
      puts "Executando bloco passado"
      block.call(m)
    end    
  end
end

foo = Foo.new
foo.huehueuhe("brbrbrbrbrbrb", 1223) { |m| puts "Bloco executado no metodo #{m}" }
=end
#
# class Foo
#   include Leaseable
# end

# monitor = LeaseMonitor.new

# foo = Foo.new
# foo2 = Foo.new
# foo3 = Foo.new

# monitor.add_to_monitor(foo)
# monitor.add_to_monitor(foo2)
# monitor.add_to_monitor(foo3)

# foo.start_lease(1)
# foo2.start_lease(2)
# foo3.start_lease(3)

# monitor.start_verify_leases

# loop {
# }
