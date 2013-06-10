require_relative 'Pool'
require_relative 'group_config'
require_relative 'Passivation'

class Lifecycle_manager
	attr_accessor :hash_register, :config, :pool, :persisted_objects, :persist, :mid

	def initialize()
		@mid = Middleware.instance
		@register = {}
		@pool = Pool.instance
		@persist = Passivation.instance
		@config = Group_config.instance
	end

  	def get_remote_object(unique_id)
  		if @config.registered.empty?
  			object = mid.remote_objects[unique_id]
  			return object
  		else
			object = mid.remote_objects[unique_id]
			return pick_object(object, unique_id)
		end
  	end

	def pick_object(object, unique_id)
		strategy = @config.get_strategy(object)

		case strategy
		
		when "Passivation"
			@persist.pick_persistable(unique_id)

		when "Poolable"
			@pool.pick(unique_id)

		#a partir daqui, não sei se precisa de tratamento proprio..
		when "Lazy"
			return @remote_objects[unique_id]

		when "Leaseable"
			pick_leaseable()

		else
			puts object.inspect
			#ObjectClassNotRegistered -> Eager_acquisition <-

		end
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

puts manager.pick_object(rebeca, rebeca.id).inspect
puts manager.pick_object(larissa, larissa.id).inspect