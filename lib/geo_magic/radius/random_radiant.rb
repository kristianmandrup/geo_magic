module GeoMagic
  class Radius < Point
    module RandomRadiant 
      def get_random_radiant range
        self.class.get_random_radiant range
      end

      def self.get_random_radiant range
        rand(range * 2) - range
      end
    end
  end
end