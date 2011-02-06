require 'spec_helper'

describe "GeoMagic Calculate" do
  before do
    @long1 = -104.88544
    @lat1 = 39.06546

    @long2 = -104.80
    @lat2 = @lat1
  end
  
  it "calculates distance using array args - using algorithm haversine" do
    dist = GeoMagic::Calculate.distance [@long1, @lat1], [@long2, @lat2]    
    puts dist    
  end

  it "Changing default distance algorithm to vincenty" do
    GeoMagic::Distance.default_formula = :vincenty
    dist = GeoMagic::Calculate.distance [@long1, @lat1], [@long2, @lat2]    
    puts dist    
  end

  it "calculates distance using Point args" do
    from_point = GeoMagic::Point.new @long1, @lat1    
    to_point = GeoMagic::Point.new @long2, @lat2
    
    puts "from: #{from_point}, to: #{to_point}"
    
    dist = GeoMagic::Calculate.distance from_point, to_point
    puts dist    
  end

  it "calculates distance using Location arg from my location" do
    from_point = GeoMagic::Remote.my_location
    to_point = GeoMagic::Point.new @long2, @lat2
    
    puts "from: #{from_point}, to: #{to_point}"
    
    dist = GeoMagic::Calculate.distance from_point, to_point
    puts dist    
  end
  
  it "calculates distance using Hash args (short)" do
    from_point = GeoMagic::Point.new(@long1, @lat1).to_point_hash :short
    to_point = GeoMagic::Point.new(@long2, @lat2).to_point_hash :long
    
    puts "from: #{from_point}, to: #{to_point}"
    
    dist = GeoMagic::Calculate.distance from_point, to_point
    puts dist    
  end
  
  it "calculates distance using Hash args (long)" do
    from_point = GeoMagic::Point.new(@long1, @lat1)
    to_point = GeoMagic::Point.new(@long2, @lat2)
  
    puts "from: #{from_point}, to: #{to_point}"
    
    dist = GeoMagic::Calculate.distance from_point, to_point
    puts dist    
  end
end
