require_relative 'Marshaller'

class Passivation
	attr_accessor :marshaller

	def initialize()
		@marshaller = Marshaller.new
	end

	def passivate(object, unique_id)
		name = object.class.to_s + unique_id.to_s
		file = File.open(name, "w+")
  		file.write(@marshaller.marshall(object)) 
  		file.close
	end

	def activate(object, unique_id)
		name = object.class.to_s + unique_id.to_s

		if File.exists?(name)
			contents = File.read(name)
			@marshaller.demarshall(contents)
		else
			:NoSuchObject
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
end


marshaller = Marshaller.new()
souzaMansur = Chutambo.new("kick", "PDshield")
aux = marshaller.marshall(souzaMansur)
igorMarques = marshaller.demarshall(aux)
passivo = Passivation.new
passivo.passivate(igorMarques)
lucasBibiano = passivo.activate(igorMarques)
p "lucas: "+lucasBibiano.inspect
=end