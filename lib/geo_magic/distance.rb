module GeoDistance
  class Haversine < DistanceFormula
    def self.point_distance( point_a, point_b, units = :meters )
      points = GeoMagic::Util.extract_points point_a, point_b
      distance *points, units
    end
  end
end

module GeoDistance
  class Spherical < DistanceFormula
    def self.point_distance( point_a, point_b, units = :meters )
      points = GeoMagic::Util.extract_points point_a, point_b
      distance *points, units
    end
  end
end

module GeoDistance
  class Vincenty < DistanceFormula
    def self.point_distance( point_a, point_b, units = :meters )
      points = GeoMagic::Util.extract_points point_a, point_b
      distance *points, units
    end
  end
end
