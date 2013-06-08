# Registro dos Configurations Groups

require 'singleton'

class Configuration_Group_Registry
	include Singleton

	registry = {}

	def registry(name, group)
		registry[name] = group
	end

end