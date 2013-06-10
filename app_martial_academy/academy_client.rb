require_relative 'academy_proxy'
require_relative 'user'
require_relative 'training'

user = User.new("1", "SeuRAUL")

training = Training.new("1", "seg", "19h", "Paulo")

acad = Academy_Proxy.new

acad.add_user user
acad.add_training training