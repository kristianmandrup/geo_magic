module GeoMagic
  class Vector 
    attr_accessor :p0, :p1
    
    def initialize p0, p1
      raise ArgumentError, "Vector must be initialized with a start end ending point, was: #{p0}, #{p1}" if ![p0, p1].are_points?
      @p0 = p0
      @p1 = p1
    end

    def create_at center, vector
      new center, center.move(vector)
    end

    def length type = nil
      rad_dist = case type
      when nil
        GeoMagic::Distance.distance(p0, p1)
      when :latitude
        (p0.latitude - p1.latitude).abs
      when :longitude
        (p0.longitude - p1.longitude).abs
      else
        raise ArgumentError, "Bad argument for calculating lenght, valid args are: nil, :latitude or :longitude"
      end
      d = GeoMagic::Distance.new rad_dist, :radians
      d.lat_factor = p0.middle_point(p1).latitude_factor if type == :latitude 
      d
    end

    def vector_distance
      GeoMagic::Distance::Vector.new length(:latitude), length(:longitude), :lat_factor => p0.middle_point(p1).latitude_factor
    end        

    def distance unit = :meters
      dist = Math.sqrt((delta_longitude + delta_latitude).abs)
      dist = ::GeoMagic::Distance.new(dist, :radians)
      dist.to_meters
    end
      
    def [] key
      case key
      when 0, :p0
        p0
      when 1, :p1
        p1
      else
        raise "Vector key must be either 0/1 or :p0/:p1"
      end
    end
    
    protected
  
    def delta_longitude
      (p0.longitude - p1.longitude)**2
    end

    def delta_latitude
      (p0.latitude - p1.latitude)**2
    end            
  end
end
