require 'geo_magic/point/class_methods'
require 'geo_magic/point/conversion'
require 'geo_magic/point/random'
require 'geo_magic/point/geo_symbols'

module GeoMagic
  class Point
    extend ClassMethods
    extend Conversion
    include Random
    include GeoMagic::PointConverter

    attr_accessor :latitude, :longitude
    
    def initialize *args
      points = case args.size
      when 2
        args
      when 1
        to_point args.first
      else
        raise ArgumentError, "Must be array of numbers or Hash of latitude, longitude"
      end
      @latitude = points.first
      @longitude = points.last
    end

    def within? shape
      raise ArgumentError, "Argument must be a GeoMagic::Shape, was #{shape}" if !shape.kind_of? GeoMagic::Shape
      shape.contains? point
    end

    # factory method
    def self.create_from *args
      latitude, longitude = case args.size 
      when 1
        args.first.extend(GeoMagic::Point::Conversion).to_point
      when 2
         args.extend(GeoMagic::Point::Conversion).to_points
      else
        raise "Bad argument to create a point from: #{args}"
      end
      new latitude, longitude
    end    

    def move dlat, dlong
      @latitude   += dlat
      @longitude  += dlong
    end
        
    def to_point_hash mode= :long
      case mode
      when :short
        {:lat => latitude, :long => longitude}
      else
        {:latitude => latitude, :longitude => longitude}        
      end
    end 

    def to_location
      raise "You need to configure the GeoMagic geocoder, see README for instructions" if !GeoMagic.geo_coder.configured?
      GeoMagic.geo_coder.instance.reverse_geocode latitude, longitude        
    end
    
    def to_s   
      "(lat: #{latitude}, long: #{longitude})"
    end
  end
end
