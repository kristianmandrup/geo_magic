require 'spec_helper'
require 'geo_magic'
require 'helper/streets'

describe "GeoMagic Geocoder" do
  let(:config_file) do
    File.expand_path('fixtures/map_api_keys.yaml', SPEC_DIR)
  end
  
  before do
    @geocoder = GeoMagic.geo_coder
    @geocoder.configure config_file, :development
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

  it "should create location and address hashes" do
    location = @geocoder.instance.geocode "Pilotystrasse 11, munich, Germany"
    p location.location_hash
    p location.address_hash
  end        

  it "Graticule adapter" do
    @geocoder = GeoMagic.geo_coder :type => :graticule, :services => :google
    @geocoder.configure config_file, :development
    location = @geocoder.instance.geocode "Pilotystrasse 11, munich, Germany"
    p location
    p location.city
  end        

  it "Graticule Multi adapter" do
    @geocoder = GeoMagic.geo_coder :type => :graticule_multi, :services => :google
    @geocoder.configure config_file, :development
    location = @geocoder.instance.geocode "Pilotystrasse 11, munich, Germany"
    p location
    p location.city
  end        


  context 'Streets from munich' do
    before do
      @geocoder = GeoMagic.geo_coder
      @geocoder.configure config_file, :development

      puts "config: #{@geocoder.config}"

      @streets = Streets.load :munich     
    end
    
    it "should not fail" do
      begin
        inst = @geocoder.instance
        
        @streets.each do |street|          
          adr = "#{street}"
          @adr = adr
          p adr
          @location = inst.geocode adr
          # p "status: #{@location.data["Status"]}"
          @location.city.should_not be_nil
          # p "city: #{@location.city}"
        end 
      rescue GeoMagic::GeoCodeError
        p "OH NO! #{@adr}"
      rescue Exception => e
        p e      
      end
    end
  end
end

