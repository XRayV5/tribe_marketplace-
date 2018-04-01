require_relative '../models/Bundle'
require_relative '../models/ComboDeal'

class Pricing
  
  def get_format_combo_deal format, qty
    bundle_combo_price = Bundle.new(format).cal_qty_per_bundle(qty).cal_price_per_bundle
    combo_total_price = cal_combo_total_price bundle_combo_price
    return ComboDeal.new(format, qty, bundle_combo_price, combo_total_price)
  end

  private
  def cal_combo_total_price bundle_combo_price
    puts bundle_combo_price.to_s
    bundle_combo_price.reduce(0) { |sum, (k ,v)| sum + v[1] }
  end
  
end