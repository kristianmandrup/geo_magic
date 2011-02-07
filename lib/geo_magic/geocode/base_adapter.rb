module GeoMagic 
  module Geocode
    class BaseAdapter
      attr_accessor :service_name, :environment
    
      def initialize services = :google, env = :default
        setup(env)
        @service_name = get_service(services)
        @environment = env
      end

      def configured?
        configured
      end

      def get_service services
        case services
        when String, Symbol
          services
        when Array
          services.first        
        else
          raise ArgumentError, "service argument is not valid: #{services.inspect}"
        end
      end

      def get_key service_name
        method = "#{service_name}_key"
        raise ArgumentError, "Invalid map service: #{service_name}, must be one of #{GeoMagic::ServiceAdapter.services_available}" if !respond_to? method
        send method 
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
      
      protected

      attr_accessor :configured
    end
  end
end