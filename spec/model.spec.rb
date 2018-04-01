require "spec_helper"

describe Bundle do
  
  describe ".initialize" do
    it "generates the bundle instance with format of IMG" do
      expect(Bundle.new("IMG").get_format).to eq "IMG"
    end

    it "generates the bundle instance with format of Flac" do
      expect(Bundle.new("Flac").get_format).to eq "Flac"
    end
    
    it "generates the bundle instance with format of VID" do
      expect(Bundle.new("VID").get_format).to eq "VID"
    end

    it "raises invalid format error when given unsupported format" do
      expect {Bundle.new("MP4")}.to raise_error(RuntimeError, "Invalid format")
    end
  end

  describe ".get_price_by_bundle" do
    it "returns correct price for bundle of format IMG" do
      expect(Bundle.new("IMG").get_price_by_bundle(5)).to eq 450
    end

    it "returns correct price for bundle of format Flac" do
      expect(Bundle.new("Flac").get_price_by_bundle(3)).to eq 427.50
    end

    it "returns correct price for bundle of format VID" do
      expect(Bundle.new("VID").get_price_by_bundle(9)).to eq 1530
    end
  end
  
  describe "Bundle.new(\"IMG\").cal_qty_per_bundle.get_qty_per_bundle" do
    before :all do
      @img_bdl = Bundle.new("IMG")
    end

    it "returns correct qty per bundle for an simple order of format IMG" do
      expect(@img_bdl.cal_qty_per_bundle(5).get_qty_per_bundle).to match_array [["10", 0], ["5", 1]]
    end

    it "returns correct qty per bundle for even order of format IMG" do
      expect(@img_bdl.cal_qty_per_bundle(15).get_qty_per_bundle).to match_array [["10", 1], ["5", 1]]
    end

    it "returns correct qty per bundle for an varied order of format IMG" do
      expect(@img_bdl.cal_qty_per_bundle(25).get_qty_per_bundle).to match_array [["10", 2], ["5", 1]]
    end
  end

  describe "Bundle.new(\"Flac.cal_qty_per_bundle\").get_qty_per_bundle" do
    before :all do
      @flac_bdl = Bundle.new("Flac")
    end

    it "returns correct qty per bundle for an simple order of format Flac" do
      expect(@flac_bdl.cal_qty_per_bundle(6).get_qty_per_bundle).to match_array [["9", 0], ["6", 1]]
    end

    it "returns correct qty per bundle for even order of format Flac" do
      expect(@flac_bdl.cal_qty_per_bundle(15).get_qty_per_bundle).to match_array [["9", 1], ["6", 1]]
    end

    it "returns correct qty per bundle for an varied order of format Flac" do
      expect(@flac_bdl.cal_qty_per_bundle(12).get_qty_per_bundle).to match_array [["9", 1], ["6", 0], ["3", 1]]
    end

    it "returns correct qty per bundle for an more varied order of format Flac" do
      expect(@flac_bdl.cal_qty_per_bundle(24).get_qty_per_bundle).to match_array [["9", 2], ["6", 1]]
    end

  end
  
  describe "Bundle.new(\"Flac.cal_qty_per_bundle\").get_qty_per_bundle" do
    before :all do
      @vid_bdl = Bundle.new("VID")
    end

    it "returns correct qty per bundle for an simple order of format VID" do
      expect(@vid_bdl.cal_qty_per_bundle(3).get_qty_per_bundle).to match_array [["9", 0], ["5", 0], ["3", 1]]
    end

    it "returns correct qty per bundle for even order of format VID" do
      expect(@vid_bdl.cal_qty_per_bundle(8).get_qty_per_bundle).to match_array [["9", 0], ["5", 1], ["3", 1]]
    end

    it "returns correct qty per bundle for an varied order of format VID" do
      expect(@vid_bdl.cal_qty_per_bundle(17).get_qty_per_bundle).to match_array [["9", 1], ["5", 1], ["3", 1]]
    end

    it "returns correct qty per bundle for an more varied order of format VID" do
      expect(@vid_bdl.cal_qty_per_bundle(13).get_qty_per_bundle).to match_array [["9", 0], ["5", 2], ["3", 1]]
    end
    # "Cannot provide a combo deal for given qty"
    it "raises 'Cannot provide a combo deal for given qty' for invalid order qty" do
      expect {@vid_bdl.cal_qty_per_bundle(16).get_qty_per_bundle}.to raise_error(RuntimeError, "Cannot provide a combo deal for given qty")
    end

  end

  describe ".cal_price_per_bundle" do
    it "calculates correct total prices for an simple order of format VID" do
      expect(Bundle.new("VID").cal_price_per_bundle([["5", 1], ["9", 1]])["5"]).to match_array([1, 900])
    end

    it "calculates correct total prices for an simple order of format Flac" do
      expect(Bundle.new("Flac").cal_price_per_bundle([["3", 1], ["9", 1]])["9"]).to match_array([1, 1147.5])
    end

    it "calculates correct total prices for an simple order of format IMG" do
      expect(Bundle.new("IMG").cal_price_per_bundle([["5", 2], ["10", 1]])["10"]).to match_array([1, 800])
    end
  end

end