module GeoMagic
  class Radius
    attr_accessor :center, :distance

    PI = 3.14159265
    PI_2 = PI * 2
    
    def initialize center, distance
      @center = center
      @distance = distance
    end  

    # Factory
    def create_point_within mode = :square
      raise ArgumentError, "mode must be :circle or :square" if ![:circle, :square].include? mode
      # Circle.create_within radius
      mode.to_s.classify.create_within self
      # send :"create_point_within_#{mode}"
    end

    include Random
  end
end