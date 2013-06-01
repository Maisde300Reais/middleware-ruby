require 'json'

class Marshaller

  def demarshall(message)

  end

  def marshall(object)
      result = "{#{object.class.to_s.downcase}: "

     object.instance_variables.each do |variable| 
        result<< "{#{variable[1..-1]}: #{object.instance_variable_get(variable)} } "
      end

      result << "}"
      puts result
  end

end
