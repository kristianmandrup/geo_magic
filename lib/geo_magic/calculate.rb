require 'geo-distance'
require 'geo_magic/point'
require 'geo_magic/util'
require 'geo_magic/location'

module GeoMagic
  module Calculate #:nodoc:
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def distance from_point, to_point, options = { :unit => :meters }
        points = extract_points from_point, to_point
        dist = ::GeoDistance.distance( *points )[options[:unit]]
        dist.number
      end    

      def plane_distance from_point, to_point, options = { :unit => :meters }
        points = extract_points from_point, to_point
        Math.sqrt((points[0] - points[2] + points[1] - points[3]).abs)
      end
    
      protected   
      
      def extract_points from_point, to_point
        [extract_point(from_point), extract_point(to_point)].flatten.map(&:to_f)
      end
    
      def extract_point point
        GeoMagic::Util.extract_point point
      end 
    end
    
    extend ClassMethods
  end
end
