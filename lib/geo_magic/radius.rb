require 'geo_magic/point'
require 'geo_magic/radius/random_radiant'

module GeoMagic
  class Radius < Point
    def initialize latitude, longitude
      super
    end  

    def random_point_within
      raise "Must be implemented by subclass"
    end

    def random_points_within number
      raise "Must be implemented by subclass"      
    end

    # allows for DSL
    # random_points(3).within
    def random_points number
      RandomPoints.new self, number
    end

    def center
      @center ||= Point.create_from self
    end

    def center= point
      @center = Point.create_from point
    end

    protected

    include RandomRadiant
  end
end


require 'geo_magic/radius/random_points'
require 'geo_magic/radius/square'
require 'geo_magic/radius/circular'
require 'geo_magic/radius/rectangular'
