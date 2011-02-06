require 'spec_helper'
require 'geo_magic'

describe "GeoMagic Calculate" do
  before do
    @long1 = -104.88544
    @lat1 = 39.06546

    @long2 = -104.80
    @lat2 = @lat1
  end
  
  it "calculates distance using array args" do
    dist = GeoMagic::Calculate.plane_distance [@long1, @lat1], [@long2, @lat2]    
    puts dist    
  end
end