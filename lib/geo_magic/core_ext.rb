class Float
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
    self * GeoDistance.radians_per_degree
  end  
  alias_method :to_radians, :rpd
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


class Integer
  ::GeoMagic::Distance::Unit.units.each do |unit|
    class_eval %{
      def #{unit}
        GeoDistance::Distance.new(self, :#{unit})
      end
    }
  end
end

class Array
  def as_map_points
    self.extend GeoMagic::MapPoints
  end
  
  def sort_by_distance
    self.sort_by { |item| get_dist_obj(item).dist }
  end  
end
