require_relative "Leaseable"

class Monitor

  def initialize
    @monitored_objects = []
  end

  def lease_expired(obj)
    puts "Lease ended: " + obj.inspect
    @monitored_objects.delete obj
  end

  def add_to_monitor(obj)
    @monitored_objects << obj
  end 

  def start_verify_leases(verify_interval)
    Thread.new do
      loop {
        
        @monitored_objects.each do |obj|
          if obj.expired_lease?
            lease_expired(obj)
          end
        end

        sleep(verify_interval)
      }
    end
  end

end

#A PARTIR DAQUI É SÓ TESTANDO LEASEABLE E LEASE_MONITOR

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

monitor.start_verify_leases(0.3)

foo.renew_lease
sleep 2

foo3.renew_lease
sleep 1
foo3.renew_lease

loop {
}