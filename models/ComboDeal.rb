class ComboDeal

  def initialize format, qty, bundle_combo_price, total_price
    @combo_format = format
    @combo_total_qty = qty
    @bundle_combo_price = bundle_combo_price
    @combo_total_price = total_price
  end
  
  def get_combo_format
    @combo_format
  end

  def get_combo_total_qty
    @combo_total_qty
  end

  def get_bundle_combo_price
    @bundle_combo_price
  end

  def get_combo_total_price
    @combo_total_price
  end

  def to_s
    header = "#{@combo_total_qty} #{@combo_format} $#{@combo_total_price}\n"
    @bundle_combo_price.reduce(header) { |acc , (bundle, combo)| "#{acc}#{combo[0]} x #{bundle} $#{combo[1]}\n" }
  end

end