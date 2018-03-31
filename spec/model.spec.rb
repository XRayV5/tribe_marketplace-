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
      expect(Bundle.new("IMG").get_price_by_bundle(5)).to eq "$450"
    end

    it "returns correct price for bundle of format Flac" do
      expect(Bundle.new("Flac").get_price_by_bundle(3)).to eq "$427.50"
    end

    it "returns correct price for bundle of format VID" do
      expect(Bundle.new("VID").get_price_by_bundle(9)).to eq "$1530"
    end
  end

end