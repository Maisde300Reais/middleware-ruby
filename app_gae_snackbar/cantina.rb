require_relative 'snackbar_gae_proxy'
require_relative 'food'

class Cantina


	def initialize()
		@proxy = SnackBarProxy.new
	end

	def gui_header()
		system("clear")
		puts "------------------------ Cantina Online ------------------------"
	end

	def gui_footer()
		puts "Pressione ENTER para voltar"
		gets
	end

	def gui_purchase()
		gui_header
		puts "Qual produto:"
		nome = gets.chomp!
		puts "Quantidade:"
		quantidade = gets.chomp!
		food = Food.new(nome, quantidade)
		@proxy.sell_food(food, food.qtd)
		gui_footer
	end

	def gui_add()
		gui_header
		puts "Qual produto:"
		nome = gets.chomp!
		puts "Quantidade:"
		quantidade = gets.chomp!
		food = Food.new(nome, quantidade)
		@proxy.add_food(food, food.qtd)
		gui_footer
	end

	def gui_show()
		gui_header
		@proxy.show_all()
		gui_footer
	end

	def gui_delete()
		gui_header
		puts("APAGAR ESTOQUE: 1 - SIM | OUTROS - NAO")
		opcao = gets.chomp!.to_i
		if opcao == 1
			@proxy.delete_all()
			puts "VOCE APAGOU O ESTOQUE!"
		else
			puts"ESTOQUE INALTERADO!"
		end
		gui_footer
	end

	def gui_error
		gui_header
		puts "OPCAO INVALIDA"
		gui_footer
	end

	def gui_main()
		gui_header
		puts "|    1 - comprar | 2 - repor estoque | 3 - mostrar estoque     |"
		puts "|opcao: "
	end

	def mainloop() 
		while true
			system("clear")
			gui_main()
			opcao = gets.chomp!.to_i
			if opcao == 1
				gui_purchase()
			elsif opcao == 2
				gui_add()
			elsif opcao == 3
				gui_show()
			elsif opcao == 10
				gui_delete()
			else
				gui_error()
			end
				
		end

	end

end

x = Cantina.new
x.mainloop
