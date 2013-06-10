require_relative '../basic_remote/marshaller'
require 'singleton'

class Passivation
	include Singleton
	attr_accessor :marshaller

	def initialize()
		@marshaller = Marshaller.new
		@persisted_objects = {}
	end

	def passivate(object, unique_id)
		@persisted_objects[unique_id]=object
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

	def pick_persistable(unique_id)

		if !@persisted_objects.include?(unique_id)
			puts "nao foi colocado em disco, de onde retornar?"
		else
			object = @persisted_objects.delete(unique_id)
			activate(object, unique_id)
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