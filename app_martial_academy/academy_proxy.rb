require_relative '../requestor'
require_relative 'academy'
require_relative 'user'
require_relative 'academy'

class Academy_Proxy
	
	def initialize
		#cadastre uma id de library e a instancia referenciada
		@r = Requestor.new("academy", Academy.new)
	end

	#cada método deve simplesmente traduzir de chamadas normais para chamadas
  #do requestor

  def add_training(training)

  	params = {}

  	params[:training_id] = training.id
  	params[:training_day] = training.day
  	params[:training_time] = training.time
  	params[:training_instructor] = training.instructor

  	p @r.invoke("academy", "add_training", params)
  end

  def add_user(user)

  	params = {}

  	params[:user_id] = user.id
  	params[:user_name] = user.name
  	params[:user_password] = user.password
  	params[:user_type] = user.type

  	p @r.invoke("academy", "add_user", params)
  end
end

def test
  training = Training.new("1", "seg", 19, "Paulo")

  user = User.new("1", "SeuRAUL")

  acad = Academy_Proxy.new

  acad.add_user user
  acad.add_training training
end