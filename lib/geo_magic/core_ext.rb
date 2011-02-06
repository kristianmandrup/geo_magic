require 'geo_magic/distance'

module GeoMagic
  module UnitExt
    ::GeoMagic::Distance::Unit.units.each do |unit|
      class_eval %{
        def #{unit}
          GeoMagic::Distance.new(self, :#{unit})
        end
      }
    end
  end
end

module GeoMagic
  module MathExt
    def round_to(x)
      (self * 10**x).round.to_f / 10**x
    end

    def ceil_to(x)
      (self * 10**x).ceil.to_f / 10**x
    end

    def floor_to(x)
      (self * 10**x).floor.to_f / 10**x
    end

    def rpd
      self * GeoMagic::Distance.radians_per_degree
    end  
    alias_method :to_radians, :rpd
  end
end

class Fixnum
  include GeoMagic::MathExt  
  include GeoMagic::UnitExt
end             

class Float
  include GeoMagic::MathExt
  include GeoMagic::UnitExt
end

class Symbol
  def radians_ratio
    GeoMagic::Distance.radians_ratio(self)
  end
end  

class String
  def radians_ratio
    self.to_sym.radians_ratio
  end
end  


class Array
  def are_points?
    each do |p|
      return false if !p.kind_of?(GeoMagic::Point)  
    end
    true
  end
  
  def as_map_points
    self.extend GeoMagic::MapPoints
  end
  
  def sort_by_distance
    self.sort_by { |item| get_dist_obj(item).dist }
  end  
end
