require_relative '../models/Bundle'

class Pricing
  def get_format_combo_deal format, qty
    bundle_combo_price = Bundle.new(format).get_qty_per_bundle(qty)
  end
end