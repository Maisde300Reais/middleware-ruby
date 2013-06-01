class Pool

	def initialize(pool_max_size = 10)
		@max_size = pool_max_size
		@actual_size = 0
		@working_objects = []
		@available_objects = []
	end

	@@instance = Pool.new

	def self.get_instance
		return @@instance
	end

	def set_size(new_size)
		@size = new_size
	end

	def add_object(object)
		if @actual_size < @max_size
			@available_objects << object
			@actual_size = @actual_size +1
		else
			:full
		end		
	end

	def acquire
		if @available_objects.empty?
			:empty
		else
			temporary_object = @available_objects[0]
			@available_objects.shift
			@working_objects << temporary_object
			return temporary_object
		end
	end

	def release(object)
		if temporary_object = @working_objects.delete(object)
			@available_objects << temporary_object
		end	
	end

	private_class_method :new
end

class Foo
	attr_accessor :id
	def initialize(n)
    @id = n
  end
end
=begin testando
obj1 = Foo.new("1")
obj2 = Foo.new("2")

pool = Pool.get_instance
pool.add_object(obj1)
pool.add_object(obj2)

user1 = pool.acquire
user2 = pool.acquire
pool.release(user1)
pool.release(user2)
puts pool.inspect
=end