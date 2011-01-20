module GeoMap
  class ServiceAdapter
    attr_reader :geo_coder

    def geocode location_str
      raise 'method #geocode must be implemented by adapter subclass'
    end

    def reverse_geocode latitude, longitude
      raise 'method #reverse_geocode should be implemented by adapter subclass'
    end          

    protected
  
    def configure root, env = :development
      @config ||= YAML.load_file("#{root}/config/google_map.yml")[env.to_s]
    end

    def google_key
      config['google_key'] 
    end    
  end
end