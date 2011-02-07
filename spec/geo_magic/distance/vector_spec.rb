require 'spec_helper'

describe GeoMagic::Distance::Vector do
  before do
    @long_dist  = -0.3
    @lat_dist   = 0.05
  end
  
  it "should create a distance vector" do
    dist_vector = GeoMagic::Distance::Vector.new @long_dist, @lat_dist
    dist_vector.long_distance.should_not be_nil
    dist_vector.lat_distance.should_not be_nil
    puts dist_vector.inspect    
  end
end