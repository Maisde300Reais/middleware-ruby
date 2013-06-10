class User

	attr_reader :id, :name, :password :type

	def initialize(id, name, password, type)
		@id = id
		@name = name
		@password = password
		@type = type
	end
end