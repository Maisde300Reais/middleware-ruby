require 'json'

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
m = Marshaller.new(5)

puts m.demarshall(  m.marshall(m))
=end

  