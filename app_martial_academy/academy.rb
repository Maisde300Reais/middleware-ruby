require_relative 'training'
require_relative 'user'

class Academy

	attr_accessor :training, :user

	def initialize
		@trainings = {}
		@users = {}
	end

	def add_training(params)
		training = Training.new(params["training_id"], params["training_day"], params["training_time"], params["training_instructor"])
		@trainings[training.id] = training
		return "> Treino de #{@trainings[training.id].day}, #{@trainings[training.id].time} cadastrado com sucesso."
	end

	def add_user(params)
		user = User.new(params["user_id"], params["user_name"])
		@users[user.id] = user
		return "> #{@users[user.id].name} cadastrado com sucesso."
	end

end