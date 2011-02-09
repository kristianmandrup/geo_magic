require 'geo_magic/point'
require 'geo_magic/radius/random_radiant'

module GeoMagic
  class Radius < Point
    def initialize arg
      super
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

    def double
      raise "Must be implemented by subclass. Should simply double the radius of the shape"
    end

    def halve
      raise "Must be implemented by subclass. Should simply halve the radius of the shape"
    end

    def multiply arg
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
