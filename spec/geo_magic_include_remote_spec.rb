require 'spec_helper'
require 'geo_magic'

class Locate
  include GeoMagic::Remote  
end

class Finder
  geo_magic :remote
end


describe "GeoMagic Remote" do
  it "should get the remote IP address" do
    ip = Locate.my_ip    
    puts "ip: #{ip.inspect}"    
  end

  it "should get other location" do
    location = Finder.location_of '74.200.247.59'
    puts "location: #{location['city']}"    
  end

  it "should get my location" do
    location = Finder.my_location
    puts location
    puts "location: #{location['city']}"    
  end

end
