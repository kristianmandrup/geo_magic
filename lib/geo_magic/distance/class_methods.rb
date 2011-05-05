module GeoMagic
  class Distance
    module ClassMethods
      # radius of the great circle in miles
      # radius in kilometers...some algorithms use 6367
      def earth_radius
        {
          :feet => 20895592, 
          :meters => 6371000,
          :kms => 6371, 
          :miles => 3956
        }
      end

      def radian_radius
        { 
          :feet => 364491.8,
          :meters => 111170,
          :kms => 111.17,
          :miles => 69.407,
          :radians => 1
        }
      end
                
      def radians_per_degree
        0.017453293  #  PI/180
      end    

      def all_units
        [:miles, :mile, :kms, :km, :feet, :foot, :meter, :meters, :radians, :rad]
      end

      def units 
        [:miles, :kms, :feet, :meters, :radians]
      end

      def valid_radius_type? type
        valid_radius_types.include? type
      end

      def valid_radius_types
        [:circular, :rectangular, :square]
      end

      def radians_ratio unit
        GeoMagic::Distance.radians_per_degree * earth_radius[unit]          
      end

      def default_formula= formula
        warn_invalid_formula if !valid_formula? formula
        @default_formula = formula 
      end

      def default_formula 
        @default_formula || :haversine
      end

      def calculate *args
        GeoMagic::Calculate.distance *args        
      end

      protected

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
