module GeoMagic
  class Distance
    class Plane < Formula
      def distance from_point, to_point, options = { :unit => :meters } 
        vector = Vector.new :formula => self
        dist = vector.distance options
        GeoMagic::Distance.new vector_distance(vector, options)        
      end    

      def vector_distance vector, options = { :unit => :meters }
        dist = Math.sqrt((delta_longitude(vector) + delta_latitude).abs)
        unit_dist = ::GeoMagic::Distance.new(dist).send unit
        unit_dist.number        
      end

      protected
    
      def delta_longitude vector
        (vector[0].longitude - vector[1].longitude)**2
      end

      def delta_latitude vector
        (vector[0].latitude - vector[1].latitude)**2
      end
    end
  end
end