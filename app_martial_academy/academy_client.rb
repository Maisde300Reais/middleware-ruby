require_relative 'academy_proxy'
require_relative 'user'
require_relative 'training'

user = User.new("1", "SeuRAUL")

training = Training.new("1", "seg", "19h", "Paulo")

acad = Academy_Proxy.new

acad.add_user user
acad.add_training training

user_id = 2
training_id = 2

opt = 1
while opt != 0
	puts "1- add user\n2- add treino\n3- ver treinos\n\n0- sair"
	opt = gets.chomp().to_i

	if opt == 1
		puts "Novo usuario: "
		usuario = gets.chomp

		user_id += 1
		user = User.new(user_id.to_s, usuario)

		acad.add_user user
	elsif opt == 2
		p "Dia do treino:"
		dia = gets.chomp
		p "Horario: "
		hora = gets.chomp
		p "Professor: "
		prof = gets.chomp

		training_id += 1
		training = Training.new(training_id.to_s, dia, hora, prof)

		acad.add_training training

	elsif opt == 3
		puts acad.list_trainings
		gets
	end
end
