module GeoMagic
  module RailsServiceAdapter
    attr_reader :geo_coder

    def geocode location_str
      raise 'method #geocode must be implemented by adapter subclass'
    end

    def reverse_geocode latitude, longitude
      raise 'method #reverse_geocode should be implemented by adapter subclass'
    end          

    protected
    
    def env 
      ENV['HEROKU_SITE'] || ::Rails.env.downcase || 'development'
    end
  
    def config
      @config ||= ::YAML.load_file("#{::Rails.root}/config/map_api_keys.yml")[env]
    end

    def google_key
      config['google_key'] 
    end    
  end  
end

