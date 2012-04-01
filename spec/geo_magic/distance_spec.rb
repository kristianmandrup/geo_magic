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
  end
end
