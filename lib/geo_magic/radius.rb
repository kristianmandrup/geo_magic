require 'geo_magic/point'
require 'geo_magic/radius/random_radiant'

module GeoMagic
  class Radius < Point
    def initialize arg
      raise ArgumentError, "Radius takes an argument with enough info to create a center point" if !arg
      super arg
    end  

    def self.types
      [:circular, :rectangular, :square]
    end

    types.each do |name|
      class_eval %{
        def create_#{name} center, distance
          #{GeoMagic::name.to_s.classify}Radius.new center, distance
        end
      }
    end

    def center
      GeoMagic::Point.new latitude, longitude
    end

    def center= arg
      point = arg.extend(GeoMagic::Point::Conversion).to_point
      latitude = point.first
      longitude = point.last
    end

    def double
      multiply 2
    end

    def double!
      multiply! 2
    end

    def halve
      multiply 0.5      
    end

    def halve!
      multiply! 0.5      
    end

    def multiply arg
      raise "Must be implemented by subclass. Should multiply size by a given factor"
    end

    def multiply! arg
      raise "Must be implemented by subclass. Should multiply size by a given factor"
    end

    # select all points within radius
    def select_within points
      raise "Must be implemented by subclass"
    end

    # reject all points within radius
    def reject_within points
      raise "Must be implemented by subclass"
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

    protected
    
    def check_numeric! arg
      raise ArgumentError, "Argument must be Numeric" if !arg.is_a? Numeric
    end

    include RandomRadiant
  end
end


require 'geo_magic/radius/random_points'
require 'geo_magic/radius/square'
require 'geo_magic/radius/circular'
require 'geo_magic/radius/rectangular'
