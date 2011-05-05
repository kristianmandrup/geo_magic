require 'geo_magic/calculate'
require 'geo_magic/distance/class_methods'
require 'geo_magic/distance/vector'
require 'geo_magic/distance/formula'
require 'geo_magic/distance/point_distance'
require 'geo_magic/distance/points_distance'

module GeoMagic 
  class Distance
    attr_accessor :distance, :unit, :lat_factor

    # The lat factor has been introduced as an experimental 'hack' in order for distance calculations for points far from the equator to result in more accurate numbers
    # when calculating and doing unit convertions. Should a similar attribute be introduced for longitude? 

    extend ClassMethods

    # select all points within radius
    def select_all points
      GeoMagic::PointsDistance.new self, points, :select
    end

    # reject all points within radius
    def reject_all points
      GeoMagic::PointsDistance.new self, points, :reject
    end

    def initialize distance, unit = :radians, options = {}
      check_numeric! distance
      @distance = distance
      raise ArgumentError, "Invalid unit: #{unit} - must be one of #{GeoMagic::Distance.units}" if !GeoMagic::Distance.units.include?(unit.to_sym)
      @unit = unit.to_sym
      @lat_factor = options[:lat_factor] || 1
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

    def to_s   
      "distance: #{distance} #{unit}"
    end    

    protected

    def check_numeric! arg
      raise ArgumentError, "Argument must be Numeric" if !arg.is_a? Numeric
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

require 'geo_magic/distance/conversion'
