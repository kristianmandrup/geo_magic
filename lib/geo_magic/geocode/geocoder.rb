require 'geo_magic/geocode/config'
require 'active_support/inflector'
require 'geocode'
require 'graticule'

module GeoMap 
  class GeoAdapter
    attr_accessor :service_name, :environment
    
    def initialize service_name = :google, env = :default
      setup(env)
      @service_name = service_name
      @environment = env
    end

    def setup env
      case env
      when :rails
        require 'rails/config'
        self.class.send(:include, RailsServiceAdapter)
      else
        self.class.send(:include, ServiceAdapter)
      end
    end
  end
  
  class GraticuleAdapter < GeoAdapter
    def initialize service_name = :google, env = :default
      super      
    end

    def instance
      @geo_coder ||= ::Graticule.service(service_name).new google_key
      self
    end
    
    def geocode location_str
      geo_coder.locate location_str
    end    
  end

  class GeocodeAdapter < GeoAdapter
    def initialize service_name = :google, env = :default
      super      
    end

    def instance
      @geo_coder ||= ::Geocode.new_geocoder service_name, {:google_api_key => google_key}      
      self
    end
    
    def geocode location_str
      geo_coder.geocode(location_str).extend GeocodeAPI
    end

    module GeocodeAPI      
      def country
        country_api["CountryNameCode"]
      end

      def country_name
        country_api["CountryName"]
      end
    
      def state
        adm_api["AdministrativeAreaName"]
      end
    
      def postal_code
        subadm_api["Locality"]["PostalCode"]["PostalCodeNumber"]
      end 
      alias_method :zip, :postal_code
    
      def street
        subadm_api["Thoroughfare"]["ThoroughfareName"]
      end

      def city
        subadm_api["SubAdministrativeAreaName"]
      end

      def latitude
        coords[0]
      end

      def longitude
        coords[1]
      end
    
      protected

      def api
        data["Placemark"].first
      end

      def coords
        api["Point"]["coordinates"]
      end

      def adr_api
        api["AddressDetails"]
      end 

      def country_api
        adr_api["Country"]
      end
    
      def adm_api
        country_api["AdministrativeArea"]        
      end
    
      def subadm_api
        adm_api["SubAdministrativeArea"]
      end
    end

    def reverse_geocode latitude, longitude
      geo_coder.reverse_geocode "#{latitude}, #{longitude}"
    end      
  end


  class << self    
    def geo_coder options = {:type => :geocode, :service_name => :google}
      service_name = options[:service_name] || :google
      type  = options[:type] || :geocode
      env   = options[:env]
      "GeoMap::#{type.to_s.classify}Adapter".constantize.new service_name, env
    end 
  
    def geocode location_str
      geo_coder.geocode location_str
    end    
  end
end