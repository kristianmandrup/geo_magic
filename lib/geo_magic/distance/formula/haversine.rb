#
# haversine formula to compute the great circle distance between two points given their latitude and longitudes
#
# Copyright (C) 2008, 360VL, Inc
# Copyright (C) 2008, Landon Cox
#
# http://www.esawdust.com (Landon Cox)
# contact:
# http://www.esawdust.com/blog/businesscard/businesscard.html
#
# LICENSE: GNU Affero GPL v3
# The ruby implementation of the Haversine formula is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License version 3 as published by the Free Software Foundation. 
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public
# License version 3 for more details.  http://www.gnu.org/licenses/
#
# Landon Cox - 9/25/08
#
# Notes:
#
# translated into Ruby based on information contained in:
#   http://mathforum.org/library/drmath/view/51879.html  Doctors Rick and Peterson - 4/20/99
#   http://www.movable-type.co.uk/scripts/latlong.html
#   http://en.wikipedia.org/wiki/Haversine_formula
#
# This formula can compute accurate distances between two points given latitude and longitude, even for
# short distances.
 
# PI = 3.1415926535 

require 'geo_magic/distance/formula'

module GeoMagic
  class Distance
    class Haversine < Formula
      def self.point_distance point_a, point_b
        points = GeoMagic::Util.extract_points point_a, point_b
        distance *points
      end

      # given two lat/lon points, compute the distance between the two points using the haversine formula
      #  the result will be a Hash of distances which are key'd by 'mi','km','ft', and 'm'
      def self.distance( lat1, lon1, lat2, lon2) 
        dlon = lon2 - lon1
        dlat = lat2 - lat1

        a = calc(dlat, lat1, lat2, dlon)
        c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))

        GeoMagic::Distance.new c
      end  

      def self.calc dlat, lat1, lat2, dlon
        (Math.sin(dlat.rpd/2))**2 + Math.cos(lat1.rpd) * Math.cos((lat2.rpd)) * (Math.sin(dlon.rpd/2))**2    
      end
    end
  end
end