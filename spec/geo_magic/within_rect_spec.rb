require 'spec_helper'
require 'geo_magic'

describe "GeoMagic within rectanlge" do
  before do
    @lat1 = 104.88544
    @long1 = 39.06546

    @center_point = GeoMagic::Point.new @lat1, @long1
    @radius = @center_point.within(10.km)
    @points = @radius.create_points_in_square 10
  end
    
  it "should select all points in rectangle" do
    rectangle = GeoMagic::Rectangle.new(GeoMagic::Point.new(115, 50), GeoMagic::Point.new(100, 20))
    points_in_rectangle = @points.as_map_points.within_rectangle rectangle
    puts "points: #{@points}"
    
    puts "---"
    
    puts "points within rectangle #{rectangle} :"
    puts points_in_rectangle.inspect
  end
end

describe "GeoMagic within rectangle - negative longitude" do
  before do
    @lat1 = -104.88544
    @long1 = 39.06546

    @center_point = GeoMagic::Point.new @lat1, @long1    
    @radius = @center_point.within(10.km)
    @points = @radius.create_points_in_square 10
  end
    
  it "should select all points in rectangle" do
    rectangle = GeoMagic::Rectangle.new(GeoMagic::Point.new(-115, 50), GeoMagic::Point.new(-100, 20))
    points_in_rectangle = @points.as_map_points.within_rectangle rectangle
    puts "points: #{@points}"
    
    puts "---"
    
    puts "points within rectangle #{rectangle} :"
    puts points_in_rectangle.inspect
  end
end

