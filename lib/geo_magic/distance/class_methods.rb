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
        GeoMagic::Distance.radians_per_degree * earth_radius[unit]          
      end

      def default_formula= formula
        warn_invalid_formula if !valid_formula? formula
        @default_formula = formula 
      end

      def distance lat1, lon1, lat2, lon2, formula = nil
        warn_invalid_formula if !valid_formula? formula

        formula ||= default_formula

        klass = case formula
        when :haversine
          GeoMagic::Distance::Haversine
        when :spherical
          GeoMagic::Distance::Spherical        
        when :vincenty
          GeoMagic::Distance::Vincenty
        else
          raise ArgumentError, "Not a valid algorithm: #{formula}. Must be one of: #{formulas}"
        end

        klass.distance lat1, lon1, lat2, lon2
      end

      def default_formula 
        @default_formula || :haversine
      end

      protected

      def valid_formula? formula
        return true if !formula
        formulas.include? formula.to_sym
      end
      
      def warn_invalid_formula
        raise ArgumentError, "Not a valid distance formula. Must be one of: #{formulas}" if !formulas.include?(name.to_sym)        
      end

      def formulas
        [:haversine, :spherical, :vincenty]
      end
    
      def wants? unit_opts, unit
        unit_opts == unit || unit_opts[unit]    
      end
    end
  end
end
