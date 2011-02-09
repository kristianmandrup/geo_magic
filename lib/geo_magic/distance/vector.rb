module GeoMagic
  class Distance
    class Vector 
      attr_accessor :lat_distance, :long_distance

      # should be Distance objects!
      def initialize lat_distance, long_distance
        raise ArgumentError "lat and long distance arguments must be instances of GeoMagic::Distance" if ![long_distance, lat_distance].kinds_of? GeoMagic::Distance
        @lat_distance   = lat_distance
        @long_distance  = long_distance
      end      

      def multiply arg
        factors = case arg
        when Fixnum
          [arg, arg]
        when Hash
          [factor(arg, [:lat, :latitude]), factor(arg, [:long, :longitude])]
        else
          raise ArgumentError, "Argument must be a Fixnum or a Hash specifying factor to multiply latitude and/or longitude with" if !arg.kind_of? 
        end                        
        multiply_lat factors.first
        multiply_long factors.last
      end

      def multiply_lat arg
        raise ArgumentError, "Argument must be a Fixnum" if !arg.kind_of? Fixnum
        self.lat_distance *= arg
      end

      def multiply_long arg
        raise ArgumentError, "Argument must be a Fixnum" if !arg.kind_of? Fixnum
        self.long_distance *= arg
      end

      def radius center
        GeoMagic::Radius.send :"create_rectangular", center, self
      end

      # should create distance vector from 2 points
      def self.create_from *args
        # extract points
        # calc distance
      end

      def to_s
        "distances: (lat: #{lat_distance}, long: #{long_distance})"
      end
      
      protected
      
      def factor hash, symbols
        s = symbols.select {|s| hash[s].kind_of? Fixnum }
        s.empty? ? 1 : hash[s]
      end
    end
  end
end