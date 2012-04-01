require 'spec_helper'

describe "GeoMagic Calculate" do
  before do
    @long1  = -104.88544
    @lat1   = 39.06546

    @long2  = -104.80
    @lat2   = @lat1
  end

  describe 'using default distance algorithm' do
    describe 'using array arguments' do
      it "should return a distance in meters > 0" do
        dist = GeoMagic::Calculate.distance [@long1, @lat1], [@long2, @lat2]
        puts dist
        dist.in_meters.should > 0
      end
    end

    describe 'using Point arguments' do    
      it "calculates distance" do
        from_point = GeoMagic::Point.new @long1, @lat1
        to_point = GeoMagic::Point.new @long2, @lat2

        puts "from: #{from_point}, to: #{to_point}"

        dist = GeoMagic::Calculate.distance from_point, to_point
        dist.in_meters.should > 0
        puts dist
      end
    end
    
    it "calculates distance using Hash args (short)" do
      from_point = GeoMagic::Point.new(@long1, @lat1).to_point_hash :short
      to_point = GeoMagic::Point.new(@long2, @lat2).to_point_hash :short

      puts "from: #{from_point}, to: #{to_point}"

      dist = GeoMagic::Calculate.distance from_point, to_point
      dist.in_meters.should > 0
      puts dist
    end

    it "calculates distance using Hash args (long)" do
      from_point = GeoMagic::Point.new(@long1, @lat1).to_point_hash :long
      to_point = GeoMagic::Point.new(@long2, @lat2).to_point_hash :long

      puts "from: #{from_point}, to: #{to_point}"

      dist = GeoMagic::Calculate.distance from_point, to_point
      dist.in_meters.should > 0
      puts dist
    end    
  end

  describe 'using vincenty distance algorithm' do
    it "Changing default distance algorithm to vincenty" do
      GeoMagic::Distance.default_formula = :vincenty
      dist = GeoMagic::Calculate.distance [@long1, @lat1], [@long2, @lat2]
      dist.in_meters.should > 0
      puts dist
    end
  end    
end
