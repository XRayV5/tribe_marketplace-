require_relative('../utils/data_helpers')
require_relative('Pricing')

class Ordering

  def initialize
    @pricing_service = Pricing.new
  end

  def process_orders
    @priced_orders = read_order_csv.reduce(Array.new) { | priced_orders, (path, order) | priced_orders.push([ path.split('/').pop, price_order(order) ]) }
    return self
  end 

  private
  def price_order order
    order.map { |(qty, format)| @pricing_service.get_format_combo_deal(format, qty.to_i) }
  end

  public
  def to_s
    puts @priced_orders
  end
end