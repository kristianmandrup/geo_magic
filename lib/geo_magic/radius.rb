module GeoMagic
  class Radius
    attr_accessor :center, :distance

    RAD_PER_DEG = 0.017453293

    # radius of the great circle in miles
    # radius in kilometers...some algorithms use 6367
    def rad
      {:km => 6371, :miles => 3956, :feet => 20895592, :meters => 6371000}                     
    end
    
    def initialize center, distance
      @center = center
      @distance = distance
    end  
    
    def create_points number
      conversion = (RAD_PER_DEG * rad[distance.unit])      

      max_radius_rad = distance.distance / conversion

      range = (max_radius_rad * normalize).to_i     

      number.times.inject([]) do |res, n|
        dlong = (get_randowm_radiant(range) / normalize) * conversion
        dlat  = (get_randowm_radiant(range) / normalize) * conversion

        point = GeoMagic::Point.new @center.latitude + dlat, @center.longitude + dlong
        res << point
        res
      end
    end  

    def get_randowm_radiant range
      rand(range) - (range / 2)
    end
    
    def normalize
      1000000.0
    end
  end
end