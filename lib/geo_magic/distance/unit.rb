module GeoMagic
  class Unit
    class << self

      def key unit
        methods.grep(/_unit/).each do |meth|
          return meth.chomp('_unit').to_sym
        end
      end
      
      protected

      def feet_unit 
        [:ft, :feet, :foot]
      end
      
      def meter_unit 
        [:m, :meter, :meters]
      end

      def km_unit 
        [:km, :kms, :kilometer, :kilometers]
      end

      def mile_unit 
        [:mil, :mile, :miles]
      end
    end
  end
end
      