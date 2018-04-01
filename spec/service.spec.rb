require "spec_helper"

describe Pricing do
  
  describe ".get_format_combo_deal" do

    it "returns a ComboDeal for specified format" do
      ComboDeal.any_instance.stub(:combo_format).and_return("VID")
      Pricing.new().get_format_combo_deal("VID", 17).combo_format.should eq("VID")
    end

    it "returns a ComboDeal with specified qty" do
      ComboDeal.any_instance.stub(:combo_total_qty).and_return(17)
      Pricing.new().get_format_combo_deal("VID", 17).combo_total_qty.should eq(17)
    end

    it "returns a ComboDeal with correct total price for this combo" do
      ComboDeal.any_instance.stub(:combo_total_price).and_return(3000)
      Pricing.new().get_format_combo_deal("VID", 17).combo_total_price.should eq(3000)
    end

    it "formats the ComboDeal into the specified correct string" do
      expect(Pricing.new().get_format_combo_deal("VID", 17).to_s).to eq "17 VID $3000\n1 x 9 $1530\n1 x 5 $900\n1 x 3 $570\n"
    end

  end

end