require 'geo_magic/distance/formula'

module GeoMagic::Distance
  class Spherical < Formula
    def self.distance( lat1, lon1, lat2, lon2) 
      from_longitude  = lon1.to_radians
      from_latitude   = lat1.to_radians
      to_longitude    = lon2.to_radians
      to_latitude     = lat2.to_radians

      c = Math.acos(
          Math.sin(from_latitude) *
          Math.sin(to_latitude) +

          Math.cos(from_latitude) * 
          Math.cos(to_latitude) *
          Math.cos(to_longitude - from_longitude)
      ) #* EARTH_RADIUS[units.to_sym]
      
      GeoDistance::Distance.new c
    end
  end
end