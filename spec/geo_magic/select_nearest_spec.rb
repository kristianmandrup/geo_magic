require 'spec_helper'
require 'geo_magic'
require 'geo_magic/remote'

describe "GeoMagic closest" do
  before do
    @long1 = -104.88544
    @lat1 = 39.06546

    @center_point = GeoMagic::Point.new @long1, @lat1    
    @radius = @center_point.within(10.km)
    @points = @radius.create_points 10
  end
    

  it "should select the closest 3 points" do
    # puts "radius: #{@radius.inspect}"    
    # puts "points: #{@points.inspect}"        
    closest = @points.as_locations.get_closest 3, :from => @center_point    
    puts "3 closest points: #{closest.inspect}"        
  end
  
  it "should select all points within 4 km" do
    # puts "radius: #{@radius.inspect}"    
    # puts "points: #{@points.inspect}"        
    closest = @points.as_locations.get_within 4.km, :from => @center_point    
    puts "points within 4 km: #{closest.inspect}"        
  end
  
end
