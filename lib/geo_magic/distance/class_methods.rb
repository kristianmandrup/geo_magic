module GeoMagic
  class Distance
    module ClassMethods
      # radius of the great circle in miles
      # radius in kilometers...some algorithms use 6367
      def earth_radius
        {:km => 6371, :miles => 3956, :feet => 20895592, :meters => 6371000}                     
      end

      def radians_per_degree
        0.017453293  #  PI/180
      end    

      def units 
        [:miles, :km, :feet, :meters]
      end

      def radians_ratio unit
        GeoDistance.radians_per_degree * earth_radius[unit]          
      end

      def default_algorithm= name
        raise ArgumentError, "Not a valid algorithm. Must be one of: #{algorithms}" if !algorithms.include?(name.to_sym)
        @default_algorithm = name 
      end

      def distance( lat1, lon1, lat2, lon2) 
        klass = case default_algorithm
        when :haversine
          GeoDistance::Haversine
        when :spherical
          GeoDistance::Spherical        
        when :vincenty
          GeoDistance::Vincenty
        else
          raise ArgumentError, "Not a valid algorithm. Must be one of: #{algorithms}"
        end
        klass.distance lat1, lon1, lat2, lon2
      end

      def default_algorithm 
        @default_algorithm || :haversine
      end

      protected

      def algorithms
        [:haversine, :spherical, :vincenty]
      end
    
      def wants? unit_opts, unit
        unit_opts == unit || unit_opts[unit]    
      end
    end
  end
end
