require_relative 'invocation'

class Quality_of_Service_Observer
  def set_start(invocation)
    #usado do lado do cliente
    #marca o tempo de início de determinada solicitacao
  end

  def invocation_received (invocation)
    #usado do lado do servidor
    #pega o tempo de início de uma requisicao e calcula quanto tempo demorou pra chegar
    #avalia a qualidade da rede
  end
end