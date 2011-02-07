require 'spec_helper'

class Array
  def to_points
    self.extend(GeoMagic::Point::Conversion).to_points
  end
end

describe GeoMagic::Point::Conversion do
  before do
    @long1 = -104.88544
    @lat1 = 39.06546

    @long2 = -104.80
    @lat2 = @lat1
  end
  
  it "convert array into points" do
    points = [@lat1, @long1, @lat2, @long2].to_points
    puts points.inspect
    dist = GeoMagic::Distance.calculate points
    puts dist    
  end

  it "convert array with inner point arrays into points" do
    points = [@lat1, @long1, @lat2, @long2].to_points
    puts points.inspect
    dist = GeoMagic::Distance.calculate points
    puts dist    
  end

  it "convert array with inner point arrays into points" do
    points = [{:long => @long1, :lat => @lat1}, [@lat2, @long2]].to_points
    puts points.inspect
    dist = GeoMagic::Distance.calculate points
    puts dist
  end
end