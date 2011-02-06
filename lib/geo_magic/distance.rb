module GeoMagic 
  class Distance
  end
end

require 'geo_magic/distance/class_methods'
require 'geo_magic/distance/unit'
require 'geo_magic/distance/vector'
require 'geo_magic/distance/formula'

module GeoMagic 
  class Distance
    attr_reader :distance, :unit

    extend ClassMethods

    def initialize distance, unit = nil
      @distance = distance
      return if !unit

      raise ArgumentError, "Invalid unit: #{unit} - must be one of #{GeoDistance.units}" if !GeoDistance.units.include?(unit.to_sym)
      @unit = unit.to_sym
    end
  
    def [] key               
      method = :"delta_#{key}"
      raise ArgumentError, "Invalid unit key #{key}" if !respond_to? method
      Distance.send "in_#{key}", send(method)
    end

    GeoDistance.units.each do |unit|
      class_eval %{
        def #{unit}
          self[:#{unit}]
        end
      }
    end

    protected
  
    # delta between the two points in miles
    GeoDistance.units.each do |unit|
      class_eval %{
        def delta_#{unit}
          GeoDistance.earth_radius[:#{unit}] * distance
        end
      }
    end

    class << self            
      GeoDistance.units.each do |unit|
        class_eval %{
          def in_#{unit} number
            Unit.new :#{unit}, number
          end
        }
      end
    end
  end
end