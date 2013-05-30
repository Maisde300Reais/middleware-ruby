module Leaseable
	attr_reader :bornTime, :timeToLease

	def initialize (timeToLease = 5)
		@bornTime = Time.now
		@timeToLease = timeToLease
	end

end

class Foo
include Leaseable
end

f = Foo.new()

while ((Time.now - f.bornTime) < f.timeToLease) do
	puts "oi"
end

puts (Time.now - f.bornTime)