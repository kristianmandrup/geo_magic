# Geocoder with Rails 3

# Expects map api keys (fx for google maps) to be defined in ROOT/config/map_api_keys.yml
# See spec/fixtures/map_api_keys.yml for example
# 
# Use @geocoder.configure(path, env) to customize this 

require 'spec_helper'
require 'geo_magic'
require 'helper/streets'

module Rails
  def self.root
    SPEC_DIR + '/fixtures'
  end
  
  def self.env
    'test'
   end  
end

describe "GeoMagic Geocoder" do
  it "should geocode for rails" do        
    @geocoder = GeoMagic.geo_coder(:env => :rails).configure
    location = @geocoder.instance.geocode "Mullerstrasse 9, Munich"
    location.city.should == 'Munich'
  end

  it "should geocode for rails with custom config file" do        
    @geocoder = GeoMagic.geo_coder(:env => :rails).configure '../map_api_keys.yaml'
    puts "config: #{@geocoder.config}"
    puts "google key: #{@geocoder.google_key}"
    location = @geocoder.instance.geocode "Mullerstrasse 9, Munich"
    location.city.should == 'Munich'
  end
end