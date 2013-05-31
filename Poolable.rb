module Poolable

	#metodo que retorna uma instancia da pool
	#importante: só deve existir uma instancia da pool (singleton pattern)
	def get_instance 
	end

	#metodo para definir o tamanho maximo que a pool deve ter
	#o tamanho influenciará nas decisoes a serem tomadas por um futuro pool manager
	def set_size
	end

	#metodo para colocar um objeto de volta na pool
	#objeto colocado na pool entrará num estado de "disponivel"
	def release_obj
	end

	#metodo para retirar um objeto da pool
	#objeto retirado da pool entrará num estado de "trabalhando"
	def acquire_obj
	end

	#**********************************************************#
	#***métodos abaixo ainda não foram implementados na pool***#
	#**********************************************************#
	
	#metodo para criar novos objetos na pool
	#este metodo deve ser utilizado quando a pool está vazia
	#provavelmente um pool manager decidirá o que fazer
	def create_new_obj
	end

end