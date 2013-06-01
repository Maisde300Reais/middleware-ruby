require_relative 'invocation'

class Lifecycle_Manager

	# vários LMs podem ser definidos pra cada estratégia 
	def initialize()

	end


	# invoker informa que precisa de um objeto
		# inicia um tempo e ativa um obj remoto
	def invocation_arrived() # objID, ...

	end

	# Depois que o invoker recebe o obj remoto avisa
		# parar o contador do invocation_arrived
	def invocation_done() # objID, ...

	end

	# ativar o obj remoto
		# Permite que o invoker o invoke
	def activate()

	end

	# desativar o obj remoto
		# definir se apaga, joga na pool, etc
	def deactive()

	end


	# para objetos complexos [sem estado trivial]
		# informa sobre futuros eventos do lifecycle
	def lifecycle_callback()

	end