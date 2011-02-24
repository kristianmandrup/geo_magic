module GeoMagic
  class Distance
    class Plane < Formula
      def distance *args
        Vector.new(*args).distance        
      end
    end
  end
end