require 'spec_helper'

describe GeoMagic::RectangularRadius do
  let(:center) do
    {:lat => 40, :long => 11}
  end

  let(:vector_distance) do
    {:lat => 1.2.km, :long => 0.4.km}
  end

  let(:distance) { 2.2.km }

  describe '#new' do      
    it "should create a new rectangular radius" do
      rect = GeoMagic::RectangularRadius.new center, vector_distance
      puts rect.inspect
    end

    it "should create a new rectangular radius that is square" do
      rect = GeoMagic::RectangularRadius.new center, distance
      rect.vector_distance.lat_distance.should == rect.vector_distance.long_distance
      puts rect.inspect
    end
  end
  
  describe '#double!' do
    let (:rect) do
      GeoMagic::RectangularRadius.new center, vector_distance
    end
    
    it "should double the radius distance" do
      old_lat = rect.vector_distance.lat_distance
      old_long = rect.vector_distance.long_distance
      rect.double! 
      rect.vector_distance.lat_distance.should == old_lat * 2
      rect.vector_distance.long_distance.should == old_long * 2
      puts rect.inspect
    end
  end

  describe '#double' do
    let (:rect) do
      GeoMagic::RectangularRadius.new center, vector_distance
    end
    
    it "should double the radius distance" do
      other_rect = rect.double
      other_rect.vector_distance.should_not == rect.vector_distance
      puts rect.inspect
    end
  end
  
  describe '#halve!' do
    let (:rect) do
      GeoMagic::RectangularRadius.new center, distance
    end
    
    it "should halve the radius distance" do
      old_lat = rect.vector_distance.lat_distance
      old_long = rect.vector_distance.long_distance
      rect.halve! 
      rect.vector_distance.lat_distance.should == old_lat / 2
      rect.vector_distance.long_distance.should == old_long / 2

      puts rect.inspect
    end
  end

  describe '#halve' do
    let (:rect) do
      GeoMagic::RectangularRadius.new center, vector_distance
    end
    
    it "should double the radius distance" do
      other_rect = rect.halve
      other_rect.vector_distance.should_not == rect.vector_distance
      puts rect.inspect
    end
  end  
end