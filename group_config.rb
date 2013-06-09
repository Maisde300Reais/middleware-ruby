class Group_config
	attr_accessor :registered

	def initialize()
		@registered = {}
	end

	def register_class_as(class_name, strategy)
		@hash_register[class_name]=strategy
	end

	def get_strategy(object)
		@hash_register[object.class]
	end

end