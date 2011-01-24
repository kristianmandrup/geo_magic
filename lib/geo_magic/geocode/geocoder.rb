require 'geo_magic/geocode/config'
require 'active_support/inflector'

require 'geo_magic/geocode/geo_adapter'
require 'geo_magic/geocode/graticule_adapter'
require 'geo_magic/geocode/geocode_adapter'

module GeoMagic 
  class << self    
    def geo_coder options = {:type => :geocode, :service => :google}
      service_name = options[:service_name] || :google
      type  = options[:type] || :geocode
      env   = options[:env]

      services = options[:services] || options[:service] || :google
      
      clazz = "GeoMagic::#{type.to_s.classify}Adapter".constantize
      
      clazz.new services, env
    end 
  
    def geocode location_str
      geo_coder.geocode location_str
    end    
  end
end