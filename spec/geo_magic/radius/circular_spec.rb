require 'spec_helper'

describe GeoMagic::CircularRadius do
  let(:center) do
    {:lat => 40, :long => 11}
  end

  let(:distance) { 3.2.km }

  let(:center_point) do
    GeoMagic::Point.new :lat => 40, :long => 11
  end


  describe '#new' do      
    it "should create a new circular radius from an array" do
      circle = GeoMagic::CircularRadius.new [30, 10], distance
      puts circle.inspect
    end

    it "should create a new circular radius" do
      circle = GeoMagic::CircularRadius.new center, distance
      puts circle.inspect
    end

    it "should create a new circular radius from a point" do
      circle = GeoMagic::CircularRadius.new center_point, distance
      puts circle.inspect
    end
  end

  describe '#multiply!' do
    let (:circle) do
      GeoMagic::CircularRadius.new center, distance
    end
    
    it "should multiply the radius distance" do
      circle.multiply!(5) 
      puts circle.inspect
    end
  end

  describe '#multiply' do
    let (:circle) do
      GeoMagic::CircularRadius.new center, distance
    end
    
    it "should multiply the radius distance and return new circle" do
      other_circle = circle.multiply(5) 
      other_circle.distance.should_not == circle.distance
      puts circle.inspect
    end
  end

  
  describe '#double' do
    let (:circle) do
      GeoMagic::CircularRadius.new center, distance
    end
    
    it "should double the radius distance and return new circle" do
      other_circle = circle.double
      other_circle.distance.should_not == circle.distance
      puts circle.inspect
    end
  end

  describe '#double!' do
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
    
    it "should halve the radius distance and return new circle" do
      other_circle = circle.halve
      other_circle.distance.should_not == circle.distance
      puts circle.inspect
    end
  end  
  
  describe '#halve!' do
    let (:circle) do
      GeoMagic::CircularRadius.new center, distance
    end
    
    it "should halve the radius distance" do
      circle.halve! 
      puts circle.inspect
    end
  end  
end