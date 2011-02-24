module GeoMagic
  class Shape
    # is point within the square
    def within? point
      raise "Subclass should implement this"
    end
    alias_method :contains?, :within?
  end
end