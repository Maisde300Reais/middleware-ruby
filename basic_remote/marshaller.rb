require 'json'
require 'savon'
require_relative 'soapProtocol'

require_relative '../utils'

class Marshaller

  def demarshall(message)
    json_object = JSON.parse(message)

    json_object.each do |class_name, attributes|

      klass = Object.const_get(class_name.to_s.capitalize)  

      params=[]      

      attributes.each do |param_name, param| 
        params << param
      end

      instance = klass.new(params.first)
      return instance

    end
  
  end

  def self.demarshall_soap_request(operation)

    operation[operation.operation_name].each do |name, param|
      params[name] =param
    end

    {
      endpoint: operation.endpoint,
      http_action: operation.soap_action,
      method: operation.operation_name,
      params: params
    }
  end

  def self.demarshall_request(request)
    if request.request_method == "GET"
      params = request.query
    else
      params = Utils.decode_params_url(request.body)
    end

    {
      http_action: request.request_method,
      url: request.path,
      method: request.path[(request.path.rindex('/') + 1)..-1],
      case_pattern: :camel_words,
      params: params
    }
  end

  def marshall(object)
    result = "{\"#{object.class.to_s.downcase}\": {"

    object.instance_variables.each do |variable| 
      result<< "\"#{variable[1..-1]}\": \"#{object.instance_variable_get(variable)}\", "
    end

    result =result[0..-3] 

    result << "}}"
  end

end

=begin
class Potato
  attr_accessor :size, :taste

  def initialize(s, t)
    @size = s
    @taste = t
  end

  def self.json_create(o)
    new(*o['data'])
  end

  def to_json(*a)
    { 'json_class' => self.class.name, 'data' => [size, taste] }.to_json(*a)
  end
end

a = Potato.new(1, "nice :D")
p JSON.dump a
p JSON.load JSON.dump a
=end

=begin
m = Marshaller.new(5)

puts m.demarshall(  m.marshall(m))
=end
=begin
sp= SoapProtocol.new

invocation = {
  endpoint: "http://localhost:8000",
  http_action: http_method.downcase,
  method: method,
  url: url,
  protocol: :rest,
  case_pattern: :camel_words,
  params: params
}

puts demarshall_soap_request(invocation).inspect
=end