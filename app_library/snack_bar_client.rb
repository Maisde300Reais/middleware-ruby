require 'snack_bar_proxy'
require 'order'
require 'food'

food= Food.new("1", "Coxinha")
order= order.new("5","Coxinha", "Dimap")

sb= Snackbar_proxy.new

sb.add_food food
sb.set_order order