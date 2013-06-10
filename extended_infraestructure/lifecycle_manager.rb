require 'singleton'
require_relative '../lifecycle_patterns/pool'
require_relative '../extended_infraestructure/group_config'
require_relative '../lifecycle_patterns/passivation'
require_relative '../middleware'

class Lifecycle_manager
	include Singleton
	attr_accessor :hash_register, :config, :pool, :persisted_objects, :persist, :mid

	def initialize()
		@mid = Middleware.instance
		@pool = Pool.instance
		@persist = Passivation.instance
		@config = Group_config.instance
	end

  	def get_remote_object(unique_id)
  		if @config.registered.empty?
  			return mid.remote_objects[unique_id]
  		else
			return pick_object(mid.remote_objects[unique_id], unique_id)
		end
  	end

  	def register_remote_object(object, unique_id)
  		strategy = @config.get_strategy(object)

  		case strategy

  		when "Leaseable"
  			object.send(:extend, Leaseable)
  			return object
  		else
  			return object
  		end
  	end

	def pick_object(object, unique_id)
		strategy = @config.get_strategy(object)

		case strategy
		
		when "Passivation"
			@persist.pick_persistable(unique_id)

		when "Poolable"
			@pool.pick(unique_id)

		when "Lazy"
			return @remote_objects[unique_id]

		when "Leaseable"
			return @remote_objects[unique_id]

		else
			:UnknownStrategy
		end
	end

end

=begin
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
=end