module GeoMagic
  class Point #:nodoc:
    attr_accessor :latitude, :longitude
    
    def initialize latitude, longitude
      @latitude = latitude
      @longitude = longitude
    end
    
    def to_hash mode= :long
      case mode
      when :short
        {:lat => latitude, :long => longitude}
      else
        {:latitude => latitude, :longitude => longitude}        
      end
    end 
    
    def to_s   
      "(lat: #{latitude}, long: #{longitude})"
    end
  end
end
