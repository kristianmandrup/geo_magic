module GeoMagic
  class Radius
    attr_accessor :center, :distance

    PI = 3.14159265
    PI_2 = PI * 2
    
    def initialize center, distance
      @center = center
      @distance = distance
    end  

    # IN BAAAAD !!! need of refactoring and DRYing up!!!


    def create_point_within mode = :square
      raise ArgumentError, "mode must be :circle or :square" if ![:circle, :square].include? mode
      send :"create_point_within_#{mode}"
    end

    include Random
  end
end