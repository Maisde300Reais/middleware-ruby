require_relative 'training'
require_relative 'user'

class Academy

	attr_accessor :training, :user

	def initialize
		@trainings = []
		@users = {}
	end

	def add_training(training)
		#training = Training.new(params["training_id"], params["training_day"], params["training_time"], params["training_instructor"])
		@trainings << training
		return "> Treino de #{training.day}, #{training.time} cadastrado com sucesso."
	end

	def add_user(user)
		#user = User.new(params["user_id"], params["user_name"])
		@users[user.id] = user
		return "> #{@users[user.id].name} cadastrado com sucesso."
	end
		
	def list_trainings
		result = "Dia | Hora | Instrutor "
		@trainings.each do |t| 
			result << "#{t.day} - #{t.time} - #{t.instructor} "
		end
		result
	end

end

def test

	user = User.new("23", "SeuRAUL")

	treino = Training.new("45", "Seg", "19h", "Paulo")
	treino2 = Training.new("46", "Qua", "19h", "Raul")

	academia = Academy.new

	academia.add_user user
	academia.add_training treino
	academia.add_training treino2

	p academia.list_trainings

end

test