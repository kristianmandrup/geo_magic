require 'geo_magic/distance'

module GeoMagic
  module UnitExt
    ::GeoMagic::Distance.all_units.each do |unit|
      class_eval %{
        def #{unit}
          GeoMagic::Distance.new(self, :#{unit})
        end
      }
    end
    
    def thousand
      self * 1000
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
  def sum 
    inject( nil ) { |sum,x| sum ? sum+x : x }
  end

  def mean 
    sum.to_f / size.to_f
  end  
  
  def is_point?
    return true if self.first.kind_of? GeoMagic::Point
    (0..1).all? {|n| self[n].is_a?(Numeric) }
  end

  def to_point
    raise "For an array to be converted to a point, it must consist of two numbers, was: #{self}" if !is_point?
    point_args = if self.first.kind_of? GeoMagic::Point
      self.first
    else
       self[0..1]
    end
    GeoMagic::Point.new point_args
  end

  def to_points
    res = []
    each_slice(2) {|point| res << point.to_point }
    res
  end
  
  def are_points?
    each do |p|
      return false if !p.kind_of?(GeoMagic::Point)  
    end
    true
  end
    
  def sort_by_distance
    self.sort_by { |item| get_dist_obj(item).dist }
  end  
end
