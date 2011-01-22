require 'geo_magic/geocode/config'
require 'active_support/inflector'
require 'geocode'
require 'graticule'

module GeoMagic 
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
      # Address
      
      def street
        thoroughfare["ThoroughfareName"]
      end

      def postal_code
        locality["PostalCode"]["PostalCodeNumber"]
      end 
      alias_method :zip, :postal_code
    
      def city
        subadm_api["SubAdministrativeAreaName"]
      end

      def state
        adm_api["AdministrativeAreaName"]
      end

      def country_code
        country_api["CountryNameCode"]
      end

      def country_name
        country_api["CountryName"].gsub(/Bundesrepublik /, '')
      end
      alias_method :country, :country_name

      def address_hash
        {:street => street, :postal_code => postal_code, :city => city, :state => state, :country => country, :country_code => country_code}
      end
    
      # Location
    
      def latitude
        coords[1]
      end

      def longitude
        coords[0]
      end

      def location_hash
        {:longitude => longitude, :latitude => latitude}
      end
    
      protected

      def thoroughfare
        @thoroughfare ||= begin
          thorough = [:subadm_api, :locality_api, :dependent_locality_api].select do |api|
            send(api)["Thoroughfare"]
          end         
          send(thorough.first)["Thoroughfare"]   
        end
      end

      def locality
        @locality ||= begin
          thorough = [:locality_api, :dependent_locality_api].select do |api|
            send(api)["PostalCode"]
          end         
          send(thorough.first)   
        end
      end

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

      def locality_api
        subadm_api["Locality"]
      end

      def dependent_locality_api
        locality_api["DependentLocality"]
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
      "GeoMagic::#{type.to_s.classify}Adapter".constantize.new service_name, env
    end 
  
    def geocode location_str
      geo_coder.geocode location_str
    end    
  end
end