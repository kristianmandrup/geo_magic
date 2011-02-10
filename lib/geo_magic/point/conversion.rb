module GeoMagic
  class Point
    module Conversion
      # convert hash or object to [x, y] of floats
      def to_points
        v = self.kind_of?(Array) ? self.map {|p| p.kind_of?(Fixnum) ? p.to_f : p.extend(GeoMagic::Point::Conversion).to_point } : self
        v.flatten.compact.map(&:to_f)
      end

      def to_vector
        points = self.to_points
        Vector.new(points[0], points[1])        
      end

      def to_point
        case self
        when GeoMagic::Point
          return [self.latitude, self.longitude]
        when Hash
          return [self[:lat], (self[:lng] || self[:long])] if self[:lat]
          return [self[:latitude], self[:longitude]] if self[:latitude]
          raise "Hash must contain either :lat, :lng or :latitude, :longitude keys to be converted to a geo point"
        when nil
          nil
        when Array
          return self.first.extend(GeoMagic::Point::Conversion).to_point if self.first.kind_of? Hash
          self.map(&:to_f)
        else
          return [self.lat, self.lng] if self.respond_to? :lat
          return [self.latitude, self.longitude] if self.respond_to? :latitude
          self.to_f
          # raise 'Object must contain either #lat, #lng or #latitude, #longitude methods to be converted to a geo point'
        end
      end
    end
  end
end
         
module GeoMagic
  module PointConverter
    protected

    def to_point v
      return v if v.kind_of? Fixnum
      v.extend(GeoMagic::Point::Conversion).to_point
    end

    def to_points v
      return v if v.kind_of? Fixnum 
      v.extend(GeoMagic::Point::Conversion).to_points
    end
  end
end