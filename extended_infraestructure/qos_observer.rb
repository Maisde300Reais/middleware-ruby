require_relative '../basic_remote/invocation'

require 'singleton'

class Quality_of_Service_Observer

	include Singleton

  def set_start(invocation)
    #usado do lado do cliente
    #marca o tempo de início de determinada solicitacao

    invocation[:qos_start_time] = Time.now

  end

  def invocation_received (invocation)
    #usado do lado do servidor
    #pega o tempo de início de uma requisicao e calcula quanto tempo demorou pra chegar
    #avalia a qualidade da rede

    received_time = invocation.[:qos_start_time] # recebo a hora que o invocation foi criado -- manipular isso

  end
end