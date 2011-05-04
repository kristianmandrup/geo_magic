require 'geo_magic/calculate'
require 'geo_magic/distance/class_methods'
# require 'geo_magic/distance/unit'
require 'geo_magic/distance/vector'
require 'geo_magic/distance/formula'
require 'geo_magic/distance/point_distance'
require 'geo_magic/distance/points_distance'

module GeoMagic 
  class Distance
    attr_accessor :distance, :unit

    extend ClassMethods

    # select all points within radius
    def select_all points
      GeoMagic::PointsDistance.new self, points, :select
    end

    # reject all points within radius
    def reject_all points
      GeoMagic::PointsDistance.new self, points, :reject
    end

    def initialize distance, unit = :radians
      check_numeric! distance
      @distance = distance
      raise ArgumentError, "Invalid unit: #{unit} - must be one of #{GeoMagic::Distance.units}" if !GeoMagic::Distance.units.include?(unit.to_sym)
      @unit = unit.to_sym
    end

    [:<, :<=, :>, :>=, :==].each do |op|
      class_eval %{
        def #{op} dist_unit
          in_meters #{op} dist_unit.in_meters
        end
      }
    end
    
    def number
      distance.round_to(precision[unit])
    end

    def * arg
      multiply arg
    end

    def / arg
      multiply(1.0/arg)
      self
    end

    def multiply arg
      check_numeric! arg
      self.distance *= arg
      self
    end

    def radius center, type = :circular
      raise ArgumentError, "Radius type must be one of: #{self.class.valid_radius_types}, was: #{type}" if !self.class.valid_radius_type? type
      GeoMagic::Radius.send :"create_#{type}", center, self
    end
  
    def [] key
      method = :"delta_#{key}"
      raise ArgumentError, "Invalid unit key #{key}" if !respond_to? method
      send(method) * distance.to_f
    end

    def self.valid_radius_type? type
      valid_radius_types.include? type
    end

    def self.valid_radius_types
      [:circular, :rectangular, :square]
    end

    (units - [:meters]).each do |unit|
      class_eval %{
        def in_#{unit}
          dist = (unit == :radians) ? in_radians : distance
          convert_to_meters(dist) * meters_map[:#{unit}]
        end

        def to_#{unit}!
          self.distance = in_meters * meters_map[:#{unit}]
          self.unit = :#{unit}
          self
        end          
      } 
    end

    def in_meters
      convert_to_meters distance
    end

    def convert_to_meters dist
      (unit == :radians) ? self[:meters] : distance / meters_map[unit]
    end

    def to_meters!
      @distance = in_meters
      @unit = :meters
      self
    end

    GeoMagic::Distance.units.each do |unit|
      class_eval %{        
        def #{unit}
          as_#{unit}
        end        

        def as_#{unit}
          in_#{unit}
        end

        def to_#{unit}
          cloned = self.dup               
          cloned.distance = in_meters * meters_map[:#{unit}]
          cloned.unit = :#{unit}
          cloned
        end        
      }
    end

    def to_radians
      cloned = self.dup               
      cloned.distance = in_radians
      cloned.unit = :radians
      cloned
    end        

    def to_radians!      
      @distance = in_radians
      @unit = :radians
    end        

    def radians_conversion_factor 
      unit.radians_ratio
    end

    def in_radians
      (unit != :radians) ? distance.to_f / earth_factor : distance # radians_conversion_factor
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
          GeoMagic::Distance.earth_radius[:#{unit}]
        end
      }
    end
    
    private

    def earth_factor u = nil
      GeoMagic::Distance.earth_radius[u ||= unit]
    end

    def meters_map
      {
       :miles => 0.00062,
       :feet => 3.28,
       :km => 0.001,
       :meters => 1 
      }
    end

    def precision
      {
        :feet => 0,
        :meters => 2,
        :km => 4,
        :miles => 4,
        :radians => 4
      }
    end    
  end
end