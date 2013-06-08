require_relative 'Marshaller'

class Passivation
	attr_accessor :marshaller

	def initialize()
		@marshaller = Marshaller.new
	end

	def passivate(object)
		file = File.open(object.class.to_s, "r+")
  		file.write(@marshaller.marshall(object)) 
	end

	def activate(object)
		name = object.class.to_s

		if File.exists?(name)
			contents = File.read(name)
			puts contents
			@marshaller.demarshall(contents)
		else
			:NoSucObject
		end

	end

end

=begin
class Chutambo
	attr_accessor :attack, :vacilo
	
	def initialize(attack="attack", defense="defense")
		@attack = attack
		@vacilo = defense
	end

	marshaller = Marshaller.new()
	souzaMansur = Chutambo.new("kick", "PDshield")
	aux = marshaller.marshall(souzaMansur)
	igorMarques = marshaller.demarshall(aux)
	passivo = Passivation.new
	passivo.passivate(igorMarques)
	lucasBibiano = passivo.activate(igorMarques)
	p "lucas: "+lucasBibiano.inspect
end
=end


