module GeoMagic
  class RectangularRadius < Radius
    attr_accessor :vector_distance

    def initialize center_point, vector_distance
      super center_point
      vector_distance = GeoMagic::Distance::Vector.create_from vector_distance
      raise ArgumentError, "#{self.class} radius distance must be a Distance::Vector with lat and long distance" if !vector_distance.kind_of? GeoMagic::Distance::Vector
      @vector_distance = vector_distance
    end  

    def multiply arg
      rect = GeoMagic::RectangularRadius.new center, vector_distance.clone
      rect.multiply! arg      
    end

    def multiply! arg
      case arg
      when Numeric
        self.vector_distance.multiply! arg
        self
      when Hash
        self.radius_from_factors [factor(arg, [:lat, :latitude]), factor(arg, [:long, :longitude])]
      else
        raise ArgumentError, "Argument must be Numeric or a Hash specifying factor to multiply latitude and/or longitude with"
      end
    end

    def create_from *args
      case args.size 
      when 1
        arg = args.first
        if arg.kind_of? GeoMagic::Rectangle
          rectangle = arg 
          new rectangle.point_a, rectangle.vector
        end
      when 2
        vector = args.to_vector
        new vector[0], vector
      end
    end

    def to_s
      "#{super}, #{vector_distance}"
    end

    def distance axis = :lat
      send :"#{axis}_distance"
    end

    def lat_distance
      vector_distance.lat_distance
    end
      
    def long_distance
      vector_distance.long_distance
    end

    # Factory
    def random_point_within
      conversion = distance.unit.radians_ratio

      max_radius_rad = distance.distance
      range = normalize max_radius_rad

      number.times.inject([]) do |res, n|
        dlong = denormalize get_random_radiant(range)
        dlat  = denormalize get_random_radiant(range)

        point = GeoMagic::Point.new @center.latitude + dlat, @center.longitude + dlong
        res << point
        res
      end      
    end 
    
    protected

    def factor hash, symbols
      s = symbols.select {|s| hash[s].is_a? Numeric }
      s.empty? ? 1 : hash[s]
    end
    
    def radius_from_factors factors
      if factors.all_same?
        self.vector_distance.multiply! factors.first.clone
        self
      else
        rectangle = GeoMagic::RectangularRadius.create_from self
        rectangle.multiply! arg
      end
    end           
  end
end