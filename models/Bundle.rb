require_relative '../db/db_helpers'

class Bundle

  def initialize format
    @format = format
    @bundles = get_bundles_by_format
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
  def get_price_by_bundle qty
    @bundles[qty.to_s]
  end

  public
  def to_s
    "Bunbles for: #{@format}"
  end

end