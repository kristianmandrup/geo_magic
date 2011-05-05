module GeoMagic
  class Shape
    attr_accessor :point_a
    
    # is point within the square
    def within? point
      raise "Subclass should implement this"
    end
    alias_method :contains?, :within?
  end
end