require 'spec_helper'

describe GeoMagic::Distance do
  context 'a 5.km distance' do
    before :each do
      @dist = 5.km
    end

    describe 'Class' do
      it "is a GeoMagic::Distance" do
        @dist.should be_a(GeoMagic::Distance)
      end
    end
    
    describe '#distance' do
      it "is 5" do
        @dist.distance.should == 5
      end
    end
    
    describe '#unit' do
      it "is :km" do
        @dist.unit.should == :km
      end
    end
    
    describe '#in_radians' do
      it "is < 1" do
        @dist.in_radians.should < 1
      end
    end
    
    describe '#radians_conversion_factor' do
      it "is > 100" do
        @dist.radians_conversion_factor.should > 100
      end
    end
    
    describe '#in_feet' do      
      it "is > 12000" do
        @dist.in_feet.should > 12000
      end
    end
    
    describe '#in_meters' do      
      it "is 5000" do
        @dist.in_meters.should == 5000
      end
    end
    
    describe '#in_miles' do      
      it "is > 3 and < 5" do
        @dist.in_miles.should < 5
        @dist.in_miles.should > 3
      end
    end
    
    describe '#in_radians' do
      it "is > 0 and < 1" do
        @dist.in_radians.should < 1
        @dist.in_radians.should > 0
      end
    end
    
    describe '#to_radians' do
      it "is > 0 and < 1" do
        puts @dist.to_radians
        @dist.to_radians.distance.should < 1
        @dist.to_radians.distance.should > 0
      end
    end
    
    describe '#to_meters!' do
      it "converts to a meter distance of 5000" do
        @dist.to_meters!
        @dist.distance.should == 5000
      end
    end
    
    describe '#to_feet!' do
      it "converts to a feet distance > 12000" do
        @dist.to_feet!
        @dist.distance.should > 12000
      end
    end

    describe '#loop conversion' do
      it "converts to miles and then back to 5000 meters" do
        @dist.to_miles!
        @dist.to_meters.distance.should == 5000
      end

      it "converts to radians and back to 5000 meters" do
        r = @dist.to_radians
        r[:km].should == 5
      end

      it "converts to radians and back to 5000 meters" do
        @dist.to_radians.to_km.distance.should == 5
      end
      
      it "converts to radians and then back to 5000 meters" do
        @dist.to_radians!
        @dist.unit.should == :radians
        @dist.distance.should < 1
        @dist.distance.should > 0
        @dist.to_meters.distance.should == 5000
      end
    end
  end
end
