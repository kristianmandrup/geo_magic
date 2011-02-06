module GeoMagic 
  module Geocode
    class GeocoderAdapter < BaseAdapter
      module API
        # Address

        def street
          thoroughfare["ThoroughfareName"] ? thoroughfare["ThoroughfareName"] : ""
        end

        def postal_code
          locality["PostalCode"] ? locality["PostalCode"]["PostalCodeNumber"] : ""
        end 
        alias_method :zip, :postal_code

        def city
          subadm_api["SubAdministrativeAreaName"] ? subadm_api["SubAdministrativeAreaName"] : ""
        end

        def state
          adm_api["AdministrativeAreaName"] ? adm_api["AdministrativeAreaName"] : ""
        end

        def country_code
          country_api["CountryNameCode"] ? country_api["CountryNameCode"] : ""
        end

        def country_name
          country_api["CountryName"] ? country_api["CountryName"] : ""
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
              x = send(api)
              x ? x["Thoroughfare"] : nil
            end         
            thorough.empty? ? {} : send(thorough.first)["Thoroughfare"]          
          end
        end

        def locality
          @locality ||= begin
            loc = [:locality_api, :dependent_locality_api].select do |api|
              x = send(api)
              x ? x["PostalCode"] || x["LocalityName"] : nil
            end
            loc.empty? ? {} : send(loc.first)          
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
    end
  end
end