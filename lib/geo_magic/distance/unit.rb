module GeoDistance 
  class Distance
    class Unit
      attr_accessor :name, :number

      def initialize name, number = 0
        @name = name
        @number = number
      end

      def number
        @number.round_to(precision[name])
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