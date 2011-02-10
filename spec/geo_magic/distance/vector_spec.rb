require 'spec_helper'

describe GeoMagic::Distance::Vector do
  before do
    @long_dist  = -0.3.km
    @lat_dist   = 0.05.km
  end
  
  it "should create a distance vector" do
    dist_vector = GeoMagic::Distance::Vector.new @long_dist, @lat_dist
    dist_vector.long_distance.should_not be_nil
    dist_vector.lat_distance.should_not be_nil
    puts dist_vector.inspect    
  end
  
  describe '#multiply!' do
    let (:dvector) do 
      GeoMagic::Distance::Vector.new @long_dist, @lat_dist
    end
    
    it "should multiply the radius distance" do
      dvector.multiply!(5) 
      puts dvector.inspect
    end
  end

  describe '#multiply' do
    let (:dvector) do 
      GeoMagic::Distance::Vector.new @long_dist, @lat_dist
    end
    
    it "should multiply the radius distance and return new circle" do
      dvector.multiply!(0.5) 
      puts dvector.inspect
    end
  end
  
end