require 'geo_magic/geocode/config'

module GeoMagic
  module RailsServiceAdapter
    include GeoMagic::ServiceAdapter
    
    def env 
      heroku = ENV['HEROKU_SITE'] if ENV         
      rails_env = ::Rails.env.downcase if ::Rails.env
      heroku || rails_env || 'development'
    end
  
    def configure file_name = 'map_api_keys.yml'
      @config ||= ::YAML.load_file("#{::Rails.root}/config/#{file_name}")[env]
      self
    end
  end  
end

