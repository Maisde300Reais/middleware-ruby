class Class
   def lazy_load(var, *args, &block)
    if not block.nil?
      block.call(var)
    end

    params = args[0]

    if params.nil?
      params = {}
      params[:load_class] = var.to_s.capitalize
    end  

    if params[:load_class]
      class_eval %Q(
        def #{var}
          @#{var} ||= #{params[:load_class]}.new
        end            
      )
    elsif params[:load_method]
      define_method var do
        if self.instance_variable_get("@#{var}".to_sym).nil?
          self.instance_variable_set("@#{var}".to_sym, send("load_#{var}")) 
        end

        self.instance_variable_get("@#{var}".to_sym)
      end
    end
  end
end

class Chutambo

  @@id = 0

  def initialize
    @@id += 1
  end

  def num_of_vacilos
    @@id
  end

end

class Foo
  lazy_load :teste, load_class: "Chutambo"
  lazy_load :ei, load_method: :load_ei
  lazy_load :chutambo
  lazy_load(:foo) { puts "Classe foo lazy load" }

  def load_ei
    Chutambo.new
  end
end



foo = Foo.new
buceta = foo.teste
puts foo.teste.num_of_vacilos
puts foo.teste.num_of_vacilos
puts foo.teste.num_of_vacilos
puts foo.teste.num_of_vacilos
puts foo.ei.num_of_vacilos
puts foo.ei.num_of_vacilos
puts foo.ei.num_of_vacilos
puts foo.ei.num_of_vacilos
puts foo.chutambo.num_of_vacilos
puts foo.chutambo.num_of_vacilos
puts foo.chutambo.num_of_vacilos
puts foo.chutambo.num_of_vacilos


=begin
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
puts hue.inspect
p hue.variavel
puts hue.inspect
p hue.variavel2
puts "=============="
=end