require 'geo_magic/shape'

module GeoMagic
  class Circle < Shape
    attr_reader :point, :distance

    def initialize point, distance
      @point_a = point
      @distance = distance
    end

    def create_within radius
      Circle.new radius.center, radius.distance
    end
  end
end