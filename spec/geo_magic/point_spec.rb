require 'spec_helper'

describe GeoMagic::Point do
  describe '#new' do  
    it "should create a new point" do
      point = GeoMagic::Point.new -10, 20
      puts point.inspect
    end
  end

  describe '#create_from' do  
    it "should create a new point" do
      point = GeoMagic::Point.create_from -10, 20
      puts point.inspect
    end

    it "should create a new point" do
      point = GeoMagic::Point.create_from :lat => -10, :long => 20
      puts point.inspect
    end
  end

  describe '#to_point_hash' do  
    it "should create a point hash" do
      point = GeoMagic::Point.create_from -10, 20
      hash = point.to_point_hash
      puts point.inspect
      puts hash.inspect
    end
  end

  describe '#to_location' do  
    it "should create a location" do
      point = GeoMagic::Point.create_from -10, 20
      lambda {point.to_location}.should raise_error
      puts point.inspect
    end
  end  

  describe '#to_s' do  
    it "should create a string rep" do
      point = GeoMagic::Point.create_from -10, 20
      str = point.to_s
      puts point.inspect
      puts str
    end
  end  
end