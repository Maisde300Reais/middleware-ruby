require_relative 'Pool'

class Lifecycle_manager
	attr_accessor :hash

	def initialize()
		@hash_register = {}
		@passivated_objects = {}
		@pool = Pool.get_instance()
	end

	#set strategy for each class here
	def register_object_as(class_name, strategy)
		@hash[class_name]=strategy
	end

	def pick_object(object, unique_id)
		strategy = @hash_register[object.class]

		case strategy
		when "Lazy"
			puts "It's Lazy, f*ck this sh*t, call it now!"

		when "Passivation"
			pick_persistable()

		when "Poolable"
			pick_poolable()

		when "Leaseable"
			pick_leaseable()

		else
			:ObjectClassNotRegistered

		end
	end

	def pick_poolable()
		puts "It's poolable, need to check if it is already at work or available"
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

class Chutambo
	attr_accessor :attack
	def initialize(id)
		@attack = attack
	end
end

manager = Lifecycle_manager.new()

rebeca = Foo.new(1)
larissa = Fuu.new(2)
igor = Chutambo.new("porrada")

manager.register_object_as(larissa.class, "Passivation")
manager.register_object_as(rebeca.class, "Lazy")
manager.register_object_as(igor.class, "Poolable")

manager.pick_object(larissa, igor.attack)
manager.pick_object(rebeca, igor.attack)
manager.pick_object(igor, igor.attack)