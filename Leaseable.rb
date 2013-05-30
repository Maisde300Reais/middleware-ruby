module Leaseable
  def startLease(monitor, time)
    @startTime = Time.now

    Thread.new do
      loop {
        if Time.now - @startTime >= time
          monitor.leaseExpired(self)
          Thread.stop
        end

        sleep 0.1
      }
    end
  end

  def renewLease
    @startTime = Time.now
  end
end

class Monitor
  def leaseExpired(obj)
    puts "Lease ended: " + obj.inspect
  end
end

class Foo
  include Leaseable
end

monitor = Monitor.new

foo = Foo.new
foo.startLease(monitor, 1)
sleep 2

