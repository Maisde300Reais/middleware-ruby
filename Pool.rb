class Pool
	attr_accessor :size

	def initialize
		@size = 5
		@working_objects = []
		@available_objects = []
	end

	@@instance = Pool.new

	def self.get_instance
		return @@instance
	end

	def set_size(new_size)
		@size = new_size
	end

	def aquire
		if @available_objects.empty?
			puts "pool vazia -- implementar isso"
		else
			puts "não tá vazia -- implementar isso"
		end
	end

	def release(object)
		@available_objects << object
	end

	private_class_method :new
end

#Pool implementando singleton com sucesso (só existirá uma instancia da pool) =D
#abaixo é só o que usei pra testar

poo1 = Pool.get_instance
puts poo1.size
poo1.set_size(7)
puts poo1.size
poo2 = Pool.get_instance
puts poo2.size
poo2.aquire