module GeoMagic
  class SquareRadius < Radius
    attr_accessor :distance
    
    def initialize center, distance
      super center
      raise ArgumentError, "#{self.class} distance must be a Distance" if !distance.kind_of? GeoMagic::Distance            
      @distance = distance
    end  

    alias_method :radius, :distance
    alias_method :radius=, :distance=

    def multiply! arg
      self.distance.multiply arg
      self
    end

    def multiply arg
      square = GeoMagic::SquareRadius.new center, distance.clone
      square.multiply! arg
    end    

    # Factory
    def random_point_within 
      conversion = GeoMagic::Distance.radians_ratio(distance.unit)

      max_radius_rad = dist.distance
      range = (max_radius_rad * normalize).to_i          

      dlong = (get_random_radiant(range) / normalize)
      dlat  = (get_random_radiant(range) / normalize)
  
      GeoMagic::Point.new @center.latitude + dlat, @center.longitude + dlong
    end    
    
    def random_points_within number
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

    def to_s
      "#{super}, #{distance}"
    end    
  end
end
