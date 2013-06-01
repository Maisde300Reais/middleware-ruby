require_relative "Leaseable"

class Monitor

  def initialize
    @monitored_objects = []
  end

  def lease_expired(obj)
    puts "Lease expired: " + obj.inspect

    result = obj.lease_expired

    @monitored_objects.delete obj if result == :delete
    obj.renew_lease if result == :renew
  end

  def add_to_monitor(obj)
    @monitored_objects << obj
  end 

  def start_verify_leases
    Thread.new do
      loop {
        @monitored_objects.each do |obj|
          if obj.expired_lease?
            lease_expired(obj)
          end
        end

        sleep(0)
      }
    end
  end

end

#
class Foo
  include Leaseable
end

monitor = Monitor.new

foo = Foo.new
foo2 = Foo.new
foo3 = Foo.new

monitor.add_to_monitor(foo)
monitor.add_to_monitor(foo2)
monitor.add_to_monitor(foo3)

foo.start_lease(1)
foo2.start_lease(2)
foo3.start_lease(3)

monitor.start_verify_leases

loop {
}
