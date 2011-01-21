require 'spec_helper'
require 'geo_magic'

describe "GeoMagic Geocoder" do
  before do
    @geocoder = GeoMap.geo_coder
    @geocoder.configure File.expand_path('../fixtures/config.yaml', File.dirname(__FILE__)), :development
  end
  
  it "should geocode" do    
    location = @geocoder.instance.geocode "Mullerstrasse 9, Munich"
    location.city.should == 'Munich'
  end

  it "should find location" do
    location = @geocoder.instance.geocode "Marienplatz 14, munich, Germany"
    p location.latitude
    p location.longitude
  end        

  # it "should geocode for rails" do        
  #   @geocoder = GeoMap.geo_coder :env => :rails    
  #   location = @geocoder.instance.geocode "Mullerstrasse 9, Munich"
  #   location.city.should == 'Munich'
  # end
end

