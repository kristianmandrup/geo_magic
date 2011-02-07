require 'spec_helper'

describe GeoMagic::Distance::Unit do  
  it "should create 5 km" do
    km_5 = GeoMagic::Distance::Unit.new :km, 5
    km_5.number.should > 0
    km_5.radians_ratio.should > 0
    
    puts "number: #{km_5.number}"
    puts "radians_ratio: #{km_5.radians_ratio}"
  end
end