require 'geo_magic/util/normalizer'

module GeoMagic
  class Point
    module Random      
      def move_random distance
        move random_deltas(range)  
      end

      def create_random_at dist_lat, dist_long
        r       = range(distance)
        dlat    = random_delta(r) * conversion
        dlong   = random_delta(r) * conversion
        GeoMagic::Point.new latitude + dlat, longitude + dlong
      end
      
      protected

      include GeoMagic::Normalizer

      # TODO: Should normalize according to unit, normalize should thus be part of distance or unit!? 
      def range distance
        normalize(distance.in_radians)
      end

      def random_deltas range
        [random_delta(range), random_delta(range)]
      end

      def random_delta range
        denormalize(get_random_radiant(range))
      end

      def get_random_radiant(range)
        GeoMagic::Radius.get_random_radiant(range)
      end      
    end
  end
end