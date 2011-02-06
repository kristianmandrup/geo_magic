module GeoMagic
  class Distance
    class Vector 
      attr_accessor :vertical_distance, :horizontal_distance
      
      def initialize vertical_distance, horizontal_distance
        @vertical_distance = vertical_distance
        @horizontal_distance = horizontal_distance
      end      
    end
  end
end