require_relative 'Pool'
require_relative 'group_config'
require_relative 'Passivation'

class Lifecycle_manager
	attr_accessor :hash_register, :config, :pool, :persisted_objects, :persist

	def initialize()
		@remote_objects = {}
		@persisted_objects = {}
		@register = {}
		@pool = Pool.instance
		@persist = Passivation.new
		@config = Group_config.instance
	end

	def register_remote_object(unique_id, object)
    	@remote_objects[unique_id] = object
    	#falta fazer a ação correspondente a criação desse obj
  	end

  	def get_remote_object(unique_id)
		object = @remote_objects[unique_id]
		return pick_object(object, unique_id)
  	end

	def pick_object(object, unique_id)
		strategy = @config.get_strategy(object)

		case strategy
		
		when "Passivation"
			pick_persistable(unique_id)

		when "Poolable"
			pick_poolable(unique_id)

		#a partir daqui, não sei se precisa de tratamento proprio..
		when "Lazy"
			return @remote_objects[unique_id]

		when "Leaseable"
			pick_leaseable()

		else
			puts object.inspect
			#ObjectClassNotRegistered -> Eager_acquisition

		end
	end

	def pick_poolable(unique_id)
		return @pool.pick(unique_id)
	end

	def pick_persistable(unique_id)

		if !@persisted_objects.include?(unique_id)
			puts "não foi colocado em disco, de onde retornar?"
		else
			object = @persisted_objects.delete(unique_id)
			@persist.activate(object, unique_id)
		end

	end

	def pick_leaseable()
		puts "It's leaseable, need to check if its lease has expired, if not expired I will renew it!"
	end

	def pick_eager()
		puts "Just gotta return the object from the lookup table!"
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

manager.pool.add(rebeca, rebeca.id)
manager.persist.passivate(larissa, larissa.id)
manager.persisted_objects[larissa.id]=larissa

puts manager.pick_object(rebeca, rebeca.id).inspect
puts manager.pick_object(larissa, larissa.id).inspect
