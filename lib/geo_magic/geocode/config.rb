module GeoMagic
  module ServiceAdapter
    attr_reader :geo_coder, :config

    def geocode location_str
      raise 'method #geocode must be implemented by adapter subclass'
    end

    def reverse_geocode latitude, longitude
      raise 'method #reverse_geocode should be implemented by adapter subclass'
    end          

    def configure path, env = :development
      @config ||= ::YAML.load_file(path)[env.to_s]
    end

    protected
  
    def google_key
      config['google_key'] 
    end    
  end
end