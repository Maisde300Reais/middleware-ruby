class Pool

	def initialize(pool_size = 10)
		@size = pool_size
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

	def acquire
		if @available_objects.empty?
			puts "pool vazia -- criar novo objeto?!"
		else
			temporary_object = @available_objects[0]
			@available_objects.shift
			@working_objects << temporary_object
			return temporary_object
		end
	end

	def release(object)
		temporary_object = @working_objects.delete(object)
		@available_objects << temporary_object
	end

	def add_object(object)
		@available_objects << object
	end

	private_class_method :new
end

#abaixo é só o que usei pra testar
class Foo
	attr_accessor :id
	def initialize(n)
    @id = n
  end
end
obj1 = Foo.new("1")
obj2 = Foo.new("2")

pool = Pool.get_instance
pool.add_object(obj1)
pool.add_object(obj2)

user1 = pool.acquire
user2 = pool.acquire
puts user1.id
puts user2.id
pool.release(user2)