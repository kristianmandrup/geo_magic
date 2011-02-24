module GeoMagic 
  class Distance
    class Unit
      attr_accessor :name, :number

      def initialize name, number = 0
        @name = name
        @number = number
      end

      def meters_map
        {:miles => 0.0062,
         :feet => 32.8,
         :km => 0.01,
         :meters => 1 
        }
      end

      def in_meters        
        meters_map[name.to_sym] * number
      end

      def to_meters!
        self.number = meters_map[name] * number
      end

      [:miles, :feet, :km].each do |unit|
        class_eval %{
          def in_#{unit}
            to_meters * meters_map[#{unit}]
          end          

          def to_#{unit}!
            self.number = to_meters * meters_map[#{unit}]
            self.name = :#{unit}
          end          
        }
      end

      [:<, :<=, :>, :>=, :==].each do |op|
        class_eval %{
          def #{op} dist_unit
            in_meters #{op} dist_unit.in_meters
          end
        }
      end
      
      def number
        @number.round_to(precision[name])
      end

      def self.units 
        GeoMagic::Distance.units
      end

      def radians_ratio
        GeoMagic::Distance.radians_ratio(name)
      end

      def to_s
        "#{number} #{name}"
      end

      private

      def precision
        {
          :feet => 0,
          :meters => 2,
          :km => 4,
          :miles => 4
        }
      end      
    end
  end
end