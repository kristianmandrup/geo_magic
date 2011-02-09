require 'spec_helper'

describe GeoMagic::CircularRadius do
  let(:center) do
    {:lat => 40, :long => 11}
  end
  let(:distance) { 3.2.km }

  describe '#new' do      
    it "should create a new circular radius" do
      circle = GeoMagic::CircularRadius.new center, distance
      puts circle.inspect
    end
  end
  
  describe '#double' do
    let (:circle) do
      GeoMagic::CircularRadius.new center, distance
    end
    
    it "should double the radius distance" do
      circle.double! 
      puts circle.inspect
    end
  end
  
  describe '#halve' do
    let (:circle) do
      GeoMagic::CircularRadius.new center, distance
    end
    
    it "should halve the radius distance" do
      circle.halve! 
      puts circle.inspect
    end
  end  
end