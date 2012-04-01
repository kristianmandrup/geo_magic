require 'geo_magic/util/normalizer'

module Geo
  class Points
    module Random      
      def move_random distance
        move random_deltas(range)  
      end

      def create_random_at dist_lat, dist_long
        r       = range(distance)
        dlat    = random_delta(r) * conversion
        dlong   = random_delta(r) * conversion
        Geo::Point.new latitude + dlat, longitude + dlong
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

      # see 'geo_shapes' gem
      def get_random_radiant(range)
        Geo::Radius::Random::Radiant.generate(range)
      end      
    end
  end
end