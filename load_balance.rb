class LoadBalance

  def initialize
    @servers=[]
  end

  def register_server(server)
    @servers<<server
  end

  def get_server(server)
      @servers.first
    end
  end

  def remove_server(server)
    @servers.delete(server)
  end

  def servers
    @servers.to_s
  end

end