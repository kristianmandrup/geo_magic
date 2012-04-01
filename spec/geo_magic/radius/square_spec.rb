require 'spec_helper'

describe GeoMagic::SquareRadius do
  let(:center) do
    {:lat => 40, :long => 11}
  end

  let(:distance) { 0.5.km }
  
  let(:center_point) do
    GeoMagic::Point.new :lat => 40, :long => 11
  end


  describe '#new' do      
    it "should create a new square radius from an array" do
      square = GeoMagic::SquareRadius.new [30, 10], distance
      puts square.inspect
    end

    it "should create a new square radius" do
      square = GeoMagic::SquareRadius.new center, distance
      puts square.inspect
    end

    it "should create a new square radius from a point" do
      square = GeoMagic::SquareRadius.new center_point, distance
      puts square.inspect
    end
  end
  
  describe '#double' do
    let (:square) do
      GeoMagic::SquareRadius.new center, distance
    end
    
    it "should double the radius distance and return new square" do
      other_square = square.double
      other_square.distance.should_not == square.distance
      puts square.inspect
    end
  end

  describe '#double!' do
    let (:square) do
      GeoMagic::SquareRadius.new center, distance
    end
    
    it "should double the radius distance" do
      square.double! 
      puts square.inspect
    end
  end

  describe '#halve' do
    let (:square) do
      GeoMagic::SquareRadius.new center, distance
    end
    
    it "should halve the radius distance and return new square" do
      other_square = square.halve
      other_square.distance.should_not == square.distance
      puts square.inspect
    end
  end  
  
  describe '#halve!' do
    let (:square) do
      GeoMagic::SquareRadius.new center, distance
    end
    
    it "should halve the radius distance" do
      square.halve! 
      puts square.inspect
    end
  end  
end