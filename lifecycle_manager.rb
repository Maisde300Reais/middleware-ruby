require_relative 'Pool'
require_relative 'group_config'

class Lifecycle_manager
	attr_accessor :hash_register, :config, :pool

	def initialize()
		@remote_objects = {}
		@hash_register = {}
		@pool = Pool.instance
		@config = Group_config.instance
	end
	
	def register_remote_object(unique_id, object)
    	@remote_objects[unique_id] = object
  	end

  	def get_remote_object(unique_id)
		object = @remote_objects[unique_id]
		return pick_object(object, unique_id)
  	end

	def pick_object(object, unique_id)
		strategy = @config.get_strategy(object)

		case strategy
		when "Lazy"
			return @remote_objects[unique_id]

		when "Passivation"
			pick_persistable()

		when "Poolable"
			pick_poolable(unique_id)

		when "Leaseable"
			pick_leaseable()

		else
			puts object.inspect
			:ObjectClassNotRegistered

		end
	end

	def pick_poolable(unique_id)
		puts "It's poolable, need to check if it is already at work or available"
		object = @pool.pick(unique_id)
	end

	def pick_persistable()
		puts "It's Persistable, need to check if it is active or persisted"
	end

	def pick_leaseable()
		puts "It's leaseable, need to check if its lease has expired, if not expired I will renew it!"
	end
	
end

class Foo
	attr_accessor :id
	def initialize(id)
		@id = id
	end
end

class Fuu
	attr_accessor :id
	def initialize(id)
		@id = id
	end
end

manager = Lifecycle_manager.new()

rebeca = Foo.new(1)
larissa = Fuu.new(2)

manager.config.register_class_as(larissa.class, "Passivation")
manager.config.register_class_as(rebeca.class, "Poolable")

manager.pick_object(larissa, larissa.id).inspect
manager.pick_object(rebeca, rebeca.id).inspect