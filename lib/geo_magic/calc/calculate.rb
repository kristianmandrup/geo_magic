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
        unit = options[:unit]
        points  = ::GeoMagic::Point.extract_points from_point, to_point
        dist    = ::GeoMagic::Distance.distance( *points ).send unit
        dist.number
      end
    end
    
    extend ClassMethods
  end
end
