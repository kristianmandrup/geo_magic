require 'spec_helper'
require 'geo_magic'
require 'geo_magic/remote'

class Person
  attr_accessor :location, :name

  def initialize name, location
    @name = name
    @location = location
  end
  
  def to_point
    location
  end
  
  class << self
    def names
      ['Hansi', 'Michel', 'Sandy', 'Sam', 'Thomas']
    end
    
    def random_at points
      points.inject([]) do |res, point|
        res << Person.new(names[rand_index], point)
        res
      end
    end
    
    def rand_index
      rand(names.size)
    end
  end
end

describe "GeoMagic closest" do
  before do
    @long1 = -104.88544
    @lat1 = 39.06546

    @center_point = GeoMagic::Point.new @long1, @lat1
    @radius = @center_point.within(10.km)
    @points = @radius.create_points_in_square 10
    
    @circle_points = @radius.create_points_in_circle 4
  end
    

  it "should select the closest 3 points" do
    # puts "radius: #{@radius.inspect}"    
    # puts "points: #{@points.inspect}"        
    closest = @points.as_map_points.the_closest 3, :from => @center_point    
    puts "3 closest points: #{closest.inspect}"        
  end
  
  it "should select all points within 5 km" do
    # puts "radius: #{@radius.inspect}"    
    # puts "points: #{@points.inspect}"        
    closest = @points.as_map_points.within_distance 5.km, :from => @center_point    
    puts "points within 4 km: #{closest.inspect}"        
  end

  it "should select all points within 4 km (circle points)" do
    # puts "radius: #{@radius.inspect}"    
    # puts "points: #{@points.inspect}"        
    closest = @circle_points.as_map_points.within_distance 4.km, :from => @center_point    
    puts "circle_points: #{@circle_points}"
    puts "points within 4 km: #{closest.inspect}"        
  end


  it "should select all points within 4 km" do
    points = @radius.create_points_in_square 4  
    persons = Person.random_at points

    center_person = Person.new 'Man in the center', @center_point
    
    people_within = persons.as_map_points.within_distance 5.km, :from => center_person
    puts "People within 4 km of Man in the center: #{people_within.inspect}"        
  end     
  
  it "should select all people in rectangle" do

    points = @radius.create_points_in_square 4  
    persons = Person.random_at points

    center_person = Person.new 'Man in the center', @center_point
    
    rectangle = GeoMagic::Rectangle.create_from_coords -115, 50, -100, 20
    
    people_in_rectangle = persons.as_map_points.within_rectangle rectangle
    puts "People in the rectangular area: #{people_in_rectangle.inspect}"        
  end
  
end
