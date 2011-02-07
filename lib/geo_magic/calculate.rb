require 'geo_magic/point'
require 'geo_magic/distance'

module GeoMagic
  module Calculate #:nodoc:
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def distance *args
        points = extract_points *args
        options = extract_options *args
        unit    = options[:unit]
        dist    = ::GeoMagic::Distance.send(:distance, *points).send unit
        dist.number
      end

      protected

      def extract_options *args
        options = last_arg_value({:unit => :meters}, args)
        {:unit => options} if options.kind_of?(Symbol)
      end        
      
      def extract_points *args
        points = case args.size
        when 2..3
          args[0..1]
        when 4..5
          args [0..3]
        else
          args.first
        end
        points.extend(GeoMagic::Point::Conversion).to_points
      end
    end
    
    extend ClassMethods
  end
end
