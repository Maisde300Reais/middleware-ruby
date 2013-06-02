class Class

   def lazy_load(name)

      class_eval %Q(
                  def #{name.keys[0]}
                    @#{name.keys[0]} ||= #{name.values[0]}.new
                  end                   
                 )
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