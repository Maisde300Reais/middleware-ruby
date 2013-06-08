# Conigurações de objs remotos com várias propriedades como QoS, Lifecycle Manager, ou communication protocol.

class Configuration_Group

	attr_accessor :lifecycle_manager_type, :qos_type, :invocation_interceptor

	def initialize(lifecycle_manager_type=nil, QoS=nil, invocation_interceptor=nil)
		@lifecycle_manager_type = lifecycle_manager_type
		@qos_type = qos_type
		@invocation_interceptor = invocation_interceptor
	end

	

end