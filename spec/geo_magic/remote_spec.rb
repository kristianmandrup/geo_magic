require 'spec_helper'
require 'geo_magic'
require 'geo_magic/remote'

describe "GeoMagic Remote" do
  it "should get the remote IP address from hostIP" do
    ip = GeoMagic::Remote::HostIP.my_ip    
    puts "ip: #{ip.inspect}"    
  end

  it "should get the remote IP address" do
    ip = GeoMagic::Remote.my_ip    
    puts "ip: #{ip.inspect}"    
  end

  it "should get other location" do
    location = GeoMagic::Remote.location_of '74.200.247.59'
    puts "location:\n#{location}"    
  end

  it "should get my location" do
    location = GeoMagic::Remote.my_location
    puts "location:\n#{location}"    
  end

end
