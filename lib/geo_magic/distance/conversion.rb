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
            un = GeoMagic::Unit.key :#{unit}
            convert_to_meters(dist) * GeoMagic::Unit.meters_map[un]
          end

          def to_#{unit}!
            un = GeoMagic::Unit.key :#{unit}
            self.distance = in_meters * GeoMagic::Unit.meters_map[un]
            self.unit = un
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

      ::GeoMagic::Distance.all_units.each do |unit|
        class_eval %{
          def #{unit}
            un = GeoMagic::Unit.key :#{unit}
            send(:"as_\#{un}")
          end
        }
      end
      
      ::GeoMagic::Distance.units.each do |unit|
        class_eval %{
          def as_#{unit}
            in_#{unit}
          end

          def to_#{unit}
            cloned = self.dup
            un = GeoMagic::Unit.key :#{unit}
            cloned.distance = in_meters * GeoMagic::Unit.meters_map[un]
            cloned.unit = un
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
            un = GeoMagic::Unit.key :#{unit}            
            GeoMagic::Distance.earth_radius[un]
          end
        }
      end

      private

      def earth_factor u = nil
        (GeoMagic::Distance.earth_radius[u ||= unit] / 180) * lat_factor
      end
    end
  end
end

module GeoMagic 
  class Distance
    include Conversion
  end
end