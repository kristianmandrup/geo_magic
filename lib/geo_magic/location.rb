module Geo
  class Location < Point
    attr_accessor :ip
    attr_writer   :city, :region, :country
    
    def create_from_raw raw_location
      raw_location.each_pair do |key, value|
        @city_name = value and next if key == 'city'
        send :"#{key}=", value
      end
    end

    # TODO
    def initialize arg
      create_from_raw arg
    end

    def [] key
      send key
    end
    
    class City
      attr_accessor :name, :metrocode, :zipcode
      
      def initialize name, zipcode, metrocode
        @name = name
        @zipcode = zipcode        
        @metrocode = metrocode
      end
      
      def to_s
        "city: #{name}#{zip_str}#{metro_str}"
      end      
      
      private

      def zip_str
        ", zipcode: #{zipcode}" if !zipcode.empty?
      end
      
      def metro_str
        ", metrocode: #{metrocode}" if !metrocode.empty?
      end
    end

    class Region
      attr_accessor :name, :code
      
      def initialize name, code
        @name = name
        @code = code        
      end 
      
      def to_s
        "region: #{name}, code: #{code}"
      end
    end

    class Country
      attr_accessor :name, :code
      
      def initialize name, code
        @name = name
        @code = code        
      end

      def to_s
        "country: #{name}, code: #{code}"
      end
    end

    def map_point
      @map_point ||= Geo::Point.new latitude, longitude
    end

    def city
      @city ||= City.new city_name, zipcode, metrocode
    end

    def region
      @region ||= Region.new region_name, region_code
    end

    def country
      @country ||= Country.new country_name, country_code
    end
    
    def to_hash mode= :long
    end

    def to_s
      "latitude: #{latitude}, longitude #{longitude}#{ip_str}\n#{city}\n#{region}\n#{country}"
    end
    
    protected
    
    attr_accessor :country_name, :country_code    
    attr_accessor :region_code, :region_name    
    attr_accessor :metrocode, :zipcode, :city_name
    
    private
    
    def ip_str
      ", :ip #{ip}" if ip
    end
  end
end