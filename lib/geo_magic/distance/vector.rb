module GeoMagic
  class Distance
    class Vector 
      attr_accessor :lat_distance, :long_distance
      
      def initialize lat_distance, long_distance
        @lat_distance   = lat_distance
        @long_distance  = long_distance
      end      

      # should create distance vector from 2 points
      def create_from *args
        # extract points
        # calc distance
      end
    end
  end
end