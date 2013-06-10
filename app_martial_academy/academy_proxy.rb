require_relative '../requestor'
require_relative 'academy'
require_relative 'user'
require_relative 'academy'

class Academy_Proxy
	
	def initialize
		#cadastre uma id de library e a instancia referenciada
		@r = Requestor.instance
	end

	#cada método deve simplesmente traduzir de chamadas normais para chamadas
  #do requestor

  def add_training(training)

  	params = {}

  	params[:training_id] = training.id
  	params[:training_day] = training.day
  	params[:training_time] = training.time
  	params[:training_instructor] = training.instructor
    params[:http_action] = "post"

  	p @r.invoke("academy", "add_training", params)
  end

  def add_user(user)

  	params = {}

  	params[:user_id] = user.id
  	params[:user_name] = user.name
    params[:http_action] = "post"

  	p @r.invoke("academy", "add_user", params)
  end

  def list_trainings
    params ={}
    params[:http_action] = "get"

    p @r.invoke("academy", "list_trainings", params)
  end
end

def test
  training = Training.new("1", "seg", "19h", "Paulo")

  user = User.new("1", "SeuRAUL")

  acad = Academy_Proxy.new

  acad.add_user user
  acad.add_training training
  acad.list_trainings
end