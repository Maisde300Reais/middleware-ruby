require 'singleton'

class Group_config
	include Singleton
	
	attr_accessor :registered

	def initialize()
		@registered = {}
	end

	def register_class_as(class_name, strategy)
		@registered[class_name]=strategy
	end

	def get_strategy(object)
		@registered[object.class]
	end

end