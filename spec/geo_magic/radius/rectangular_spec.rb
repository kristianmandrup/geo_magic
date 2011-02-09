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
      puts rect.inspect
    end
  end
  
  describe '#double' do
    let (:rect) do
      GeoMagic::RectangularRadius.new center, vector_distance
    end
    
    it "should double the radius distance" do
      rect.double! 
      puts rect.inspect
    end
  end
  
  describe '#halve' do
    let (:rect) do
      GeoMagic::RectangularRadius.new center, distance
    end
    
    it "should halve the radius distance" do
      rect.halve! 
      puts rect.inspect
    end
  end
  
end