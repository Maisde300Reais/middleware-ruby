require_relative '../basic_remote/requestor'
require_relative 'training'

class Academy_Proxy

	def initialize
    @r = Requestor.instance
  end

  def add_training(training)

  	params={}

  	params[:http_action] = "put"
  	params[:t_day] = training.day
  	params[:t_time] = training.time
  	params[:t_instructor] = training.instructor

  	p @r.invoke("seuraul-pd-app", "academy", params)
  end

  def get_trainings()

  	params[:http_action] = "get"

  	p @r.invoke("seuraul-pd-app", "academy", params)
  end

  def delete_training(t_day)

  	params[:http_action] = "put"
  	params[:t_day] = t_day

  	p @r.invoke("seuraul-pd-app", "academy", params)
  end

end

def teste
	training = Training.new("Ter", "17h", "SeuRAUL")

	a = Academy_Proxy.new

	a.add_training(training)

	a.get_trainings()

	a.delete_training("Ter")
end

teste