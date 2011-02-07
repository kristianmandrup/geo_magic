module GeoMagic
  class Point
    module Random
      def move_random distance
        conversion = distance.unit.radians_ratio

        max_radius_rad = dist.distance
        range = (max_radius_rad * normalize).to_i          

        dlong = (get_random_radiant(range) / normalize)
        dlat  = (get_random_radiant(range) / normalize)
  
        @latitude   += dlat
        @longitude  += dlong
      end

      def create_random_at dist_lat, dist_long
        dlat  = (get_random_radiant(range) / normalize) * conversion
  
        GeoMagic::Point.new dist.latitude + dlat, dist.longitude + dlong      
      end
      
      protected

      def get_random_radiant(range)
        GeoMagic::Radius.get_random_radiant(range)
      end      
    end
  end
end