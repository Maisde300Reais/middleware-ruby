require_relative 'snack_bar_proxy'
require_relative 'order'
require_relative 'food'

food= Food.new("1", "Coxinha")
order= Order.new("5","Coxinha", "Dimap")

sb= Snackbar_proxy.new

sb.add_food food
sb.set_order order