module GeoMagic 
  class Distance
    module Conversion
      def [] key
        raise ArgumentError, "Invalid unit key #{key}" if !respond_to? key
        earth_factor(key) * distance.to_f
      end

      (::GeoMagic::Distance.units - [:meters]).each do |unit|
        class_eval %{
          def in_#{unit}
            dist = (unit == :radians) ? in_radians : distance
            convert_to_meters(dist) * meters_map[:#{unit}]
          end

          def to_#{unit}!
            self.distance = in_meters * meters_map[:#{unit}]
            self.unit = :#{unit}
            self
          end          
        } 
      end

      def in_meters
        convert_to_meters distance
      end

      def convert_to_meters dist
        (unit == :radians) ? self[:meters] : distance / meters_map[unit]
      end

      def to_meters!
        @distance = in_meters
        @unit = :meters
        self
      end

      ::GeoMagic::Distance.units.each do |unit|
        class_eval %{        
          def #{unit}
            as_#{unit}
          end        

          def as_#{unit}
            in_#{unit}
          end

          def to_#{unit}
            cloned = self.dup               
            cloned.distance = in_meters * meters_map[:#{unit}]
            cloned.unit = :#{unit}
            cloned
          end        
        }
      end

      def to_radians
        cloned = self.dup               
        cloned.distance = in_radians
        cloned.unit = :radians
        cloned
      end        

      def to_radians!      
        @distance = in_radians
        @unit = :radians
      end        

      def radians_conversion_factor 
        unit.radians_ratio
      end

      def in_radians
        (unit != :radians) ? distance.to_f / earth_factor : distance # radians_conversion_factor
      end

      protected

      # delta between the two points in miles
      GeoMagic::Distance.units.each do |unit|
        class_eval %{
          def delta_#{unit}
            GeoMagic::Distance.earth_radius[:#{unit}]
          end
        }
      end

      private

      def earth_factor u = nil
        (GeoMagic::Distance.earth_radius[u ||= unit] / 180) * lat_factor
      end

      def meters_map
        {
         :miles => 0.00062,
         :feet => 3.28,
         :km => 0.001,
         :meters => 1 
        }
      end
    end
  end
end

module GeoMagic 
  class Distance
    include Conversion
  end
end