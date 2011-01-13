require 'haversine'
require 'geo_magic/point'
require 'geo_magic/util'

module GeoMagic
  module Calculate #:nodoc:
    def self.distance from_point, to_point, options = { :unit => :meters }
      points = [extract_point(from_point), extract_point(to_point)].flatten
      dist = Haversine.distance( *points )[options[:unit]]
      puts "the distance from  (#{points[0]}, #{points[1]}) to (#{points[2]}, #{points[3]}) is: #{dist}"
      dist.number
    end    
    
    protected   
    
    def self.extract_point point
      GeoMagic::Util.extract_point point
    end 
  end
end
