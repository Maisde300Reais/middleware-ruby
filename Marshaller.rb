require 'json'

class Marshaller

  attr_accessor :lol, :hue

  def initialize(lol)
    @lol=lol
    @hue=1213
  end

  def demarshall(message)
    json_object = JSON.parse(message)

    puts json_object
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

puts m.marshall(m)

hue = {}

hue["lol"] = "5"
hue2="{\"key\": \"a string\"}"
m.demarshall(  m.marshall(m))

=end