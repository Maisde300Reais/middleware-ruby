class Pool
	attr_accessor :size

	def initialize
		@size = 5
		@max_size = 10
	end

	@@instance = Pool.new

	def self.get_instance
		return @@instance
	end

	def set_size(new_size)
		@size = new_size
	end

	private_class_method :new
end

#Pool implementando singleton com sucesso (só existirá uma instancia da pool) =D

poo1 = Pool.get_instance
puts poo1.size
poo1.set_size(7)
puts poo1.size
poo2 = Pool.get_instance
puts poo2.size