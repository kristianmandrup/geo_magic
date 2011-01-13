require 'spec_helper'
require 'geo_magic'

class Map
  include GeoMagic::Calculate
end

class MapCalc
  geo_magic :calc
end


describe "GeoMagic" do
  before do
    @long1 = -104.88544
    @lat1 = 39.06546

    @long2 = -104.80
    @lat2 = @lat1
  end
  
  it "calculates distance using array args" do
    dist = Map.distance [@long1, @lat1], [@long2, @lat2]    
    puts dist    
  end

  it "calculates distance using Point args" do
    from_point = GeoMagic::Point.new @long1, @lat1    
    to_point = GeoMagic::Point.new @long2, @lat2
    
    puts "from: #{from_point}, to: #{to_point}"
    
    dist = Map.distance from_point, to_point
    puts dist    
  end
end