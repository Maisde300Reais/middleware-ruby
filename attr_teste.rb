class Class
   def lazy_load(*args)

      args.each do |var|       
        define_method var do
          if self.instance_variable_get("@#{var}".to_sym).nil?
            self.instance_variable_set("@#{var}".to_sym, send("load_#{var}")) 
          end

          self.instance_variable_get("@#{var}".to_sym)
        end
      end
   end
end

=begin 
class ExpensiveObject
  def initialize
    # Expensive stuff here.
  end
end
  
class Caller
  def some_method
    my_object.do_something
  end

  def my_object
    # Expensive object is created when my_object is called. Subsequent calls
    # will return the same object.
    @my_object ||= ExpensiveObject.new
  end
end
=end

class Hue
  lazy_load :variavel, :variavel2

  def fibonnacci(n)
    return 1 if n <= 2

    return fibonnacci(n - 1) + fibonnacci(n - 2)
  end

  def load_variavel
    fibonnacci(15)
  end

  def load_variavel2
    fibonnacci(30)
  end
end

puts "=============="
hue = Hue.new
p hue.variavel
p hue.variavel2
puts "=============="

class Buceta

  @@id = 0

  def initialize
    @@id += 1
  end

  def num_of_bucetas
    @@id
  end

end

class Foo
  lazy_load :teste => "Buceta"
  lazy_load :ei => "Buceta"
end

foo = Foo.new
puts "inspect-> " + foo.inspect
buceta = foo.teste
puts foo.teste.num_of_bucetas
puts "inspect-> " + foo.inspect
#só carrega o objeto buceta dentro de Foo qnd o metodo teste eh chamado