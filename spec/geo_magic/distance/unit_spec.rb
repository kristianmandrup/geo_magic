require 'spec_helper'

describe GeoMagic::Distance::Unit do
  context "5 km distance" do  

    subject { GeoMagic::Distance::Unit.new :km, 5 }

    its(:number)        { should > 0 }
    its(:radians_ratio) { should > 0 }
    its(:in_meters)     { should == 5000 }
    its(:in_feet)       { should > 100 }    
    its(:in_km)         { should == 5 }
    its(:in_miles)      { should < 5 }
  end
  
  context "5km and 7000m" do
    before do
      @km     = GeoMagic::Distance::Unit.new :km, 5
      @meters = GeoMagic::Distance::Unit.new :meters, 7000
    end
    
    it "should be that 5km is less than 7000m" do
      (@km < @meters).should be_true
      (@km > @meters).should be_false
      (@km == @meters).should be_false
    end
  end
end