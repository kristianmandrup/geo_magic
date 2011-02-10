require 'geo_magic/calculate'
require 'geo_magic/distance/class_methods'
require 'geo_magic/distance/unit'
require 'geo_magic/distance/vector'
require 'geo_magic/distance/formula'

module GeoMagic 
  class Distance
    attr_accessor :distance, :unit

    extend ClassMethods

    def initialize distance, unit = nil
      @distance = distance
      return if !unit

      raise ArgumentError, "Invalid unit: #{unit} - must be one of #{GeoMagic::Distance.units}" if !GeoMagic::Distance.units.include?(unit.to_sym)
      @unit = unit.to_sym
    end

    # select all points within radius
    def select_within points, center      
    end

    # reject all points within radius
    def reject_within points, center
      
    end

    def * arg
      multiply arg
    end

    def / arg
      multiply(1/arg)
    end


    def multiply arg
      check_numeric! arg
      self.distance *= arg
    end

    def radius center, type = :circular
      raise ArgumentError, "Radius type must be one of: #{self.class.valid_radius_types}, was: #{type}" if !self.class.valid_radius_type? type
      GeoMagic::Radius.send :"create_#{type}", center, self
    end
  
    def [] key
      method = :"delta_#{key}"
      raise ArgumentError, "Invalid unit key #{key}" if !respond_to? method
      Distance.send "in_#{key}", send(method)
    end

    def self.valid_radius_type? type
      valid_radius_types.include? type
    end

    def self.valid_radius_types
      [:circular, :rectangular]
    end

    GeoMagic::Distance.units.each do |unit|
      class_eval %{
        def #{unit}
          self[:#{unit}]
        end
      }
    end

    def conversion 
      unit.radians_ratio
    end

    def in_radians
      distance * conversion
    end

    def to_s   
      "distance: #{distance} #{unit}"
    end    

    protected

    def check_numeric! arg
      raise ArgumentError, "Argument must be Numeric" if !arg.is_a? Numeric
    end
  
    # delta between the two points in miles
    GeoMagic::Distance.units.each do |unit|
      class_eval %{
        def delta_#{unit}
          GeoMagic::Distance.earth_radius[:#{unit}] * distance
        end
      }
    end

    class << self            
      GeoMagic::Distance.units.each do |unit|
        class_eval %{
          def in_#{unit} number
            Unit.new :#{unit}, number
          end
        }
      end
    end
  end
end