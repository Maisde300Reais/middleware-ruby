require 'json'

class Marshaller

  def demarshall(message)

    json_object = JSON.parse(message)

    json_object.each do |class_name, params|

      klass = Object.const_get(class_name.to_s.capitalize)

      klass.inspect

      params.each do |param_name, param| 
        puts param_name
      end
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


m.demarshall(  m.marshall(m))
=end

  