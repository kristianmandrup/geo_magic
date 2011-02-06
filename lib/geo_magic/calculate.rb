require 'geo_magic/point'
require 'geo_magic/distance'

module GeoMagic
  module Calculate #:nodoc:
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def distance *args
        options = last_arg_value({:unit => :meters}, args)
        puts "args: #{args.inspect}"
        points = case args.size
        when 2..3
          args[0..1]
        when 4..5
          args [0..3]
        else
          args.first
        end

        options = {:unit => options} if options.kind_of?(Symbol)        
        unit    = options[:unit]
        points = points.extend(GeoMagic::Point::Conversion).to_points
        
        dist    = ::GeoMagic::Distance.distance( *points ).send unit
        dist.number
      end
    end
    
    extend ClassMethods
  end
end
