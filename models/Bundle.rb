require_relative '../utils/data_helpers'

class Bundle

  def initialize format
    @format = format
    @bundles = get_bundles_by_format
    @qty_per_bundle
  end
  
  private
  def get_bundles_by_format
    bundles_by_format = fetch_bundles[@format]
    bundles_by_format.nil? ? (raise "Invalid format") : bundles_by_format
  end
  
  public
  def get_format
    @format
  end

  public
  def get_price_by_bundle base
    @bundles[base.to_s]
  end

  public 
  def get_qty_per_bundle
    @qty_per_bundle
  end

  public 
  def cal_qty_per_bundle qty
    bundle_bases = @bundles.keys.map(&:to_i).sort { |k1, k2| k1 > k2 ? -1 : 1 }
    @qty_per_bundle = get_bundle_combo(bundle_bases, qty, []).map.with_index { | qty, i | [ bundle_bases[i].to_s, qty ] }
    @qty_per_bundle.select! { | (bundle, qty) | qty != 0 }
    self
  end

  public
  def cal_price_per_bundle given_bundle = nil
    if given_bundle != nil
        return Hash[given_bundle.map { | k, v | [k, [v, @bundles[k] * v]] }]
      else
        return Hash[@qty_per_bundle.map { | k, v | [k, [v, @bundles[k] * v]] }]
    end
  end

  private 
  def get_bundle_combo bundle_bases, qty, combo
    step_combo = probe_bundle_combo(bundle_bases.clone, qty, combo)
    if step_combo == nil
      combo = Array.new(bundle_bases.length - combo.length + 1, 0)
      if bundle_bases[1..-1].empty? 
        raise "Cannot provide a combo deal for given qty" 
      end
      get_bundle_combo(bundle_bases[1..-1], qty, combo)
    else
      return step_combo
    end
  end

  private 
  def probe_bundle_combo bundle_bases, qty, combo
    if bundle_bases.empty?
      return nil
    elsif qty % bundle_bases.first == 0
      return combo.push(qty / bundle_bases.first)
    else
      div, mod = qty.divmod(bundle_bases.shift)
      combo.push(div)
      probe_bundle_combo bundle_bases, mod, combo
    end
  end
  
end