require_relative 'invocation'

require 'singleton'

class Quality_of_Service_Observer

	include Singleton

  def initialize
    @times = {}
  end

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

    @times[:qos_start_time] = received_time
  end

  def average_time
    times = []
    @times.each do |id, t|
      times << "#{t}"
    end
    averange = (times.max + times.min) / 2
    puts "Max: #{times.max}\nMin: #{times.min}\nMedia: #{averange}"
  end
end