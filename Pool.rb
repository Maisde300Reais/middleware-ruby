require 'singleton'

class Pool

	include Singleton

	def initialize()
		@available = {}
		@working = {}
	end

	def add(object ,unique_id)		
		if @available[unique_id] != nil || @working[unique_id] != nil
			:ObjectAlreadyPooled
		else
			@available[unique_id]=object
		end
	end

	def pick(unique_id)
		if @available[unique_id]
			object = @available.delete(unique_id)
			@working[unique_id]=object
		else
			:ObjectNotAvailable
		end
		
	end

	def release(unique_id)
		if @working[unique_id]
			object = @working.delete(unique_id)
			@available[unique_id]=object
		else
			:ObjectNotWorking
		end
		
	end

	private_class_method :new
end

=begin

class Foo
	attr_accessor :id
	def initialize(id)
		@id = id
	end
end

pool = Pool.instance
obj1 = Foo.new(3)
obj2 = Foo.new(219821)

pool.add(obj1, obj1.id)
pool.add(obj2, obj2.id)

p pool.inspect
user = pool.pick(obj2.id)
p pool.inspect
user1 = pool.pick(obj1.id)
p pool.inspect
pool.release(obj1.id)
p pool.inspect
=end
