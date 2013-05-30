require 'rest_client'

require_relative 'Invocation'

class RestProtocol

  def send_message(endpoint, invocation)

    client = Savon.client(wsdl: endpoint)

    response = client.call(:"#{invocation.method}", message: invocation.params)

  end

  def get_operations(endpoint)

    client = Savon.client(wsdl: endpoint)
    client.operations
  
  end

end