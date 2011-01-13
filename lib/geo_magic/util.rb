module GeoMagic
  module Util #:nodoc:
    def self.extract_point point
      case point
      when Hash
        [ point[:lat] || point[:latitude], point[:long] || point[:longitude] ]      
      when GeoMagic::Point
        [point.latitude, point.longitude]
      when GeoMagic::Location
        [point.latitude, point.longitude]
      when Array
        [point[0], point[1]]
      end
    end
  end
end
