require 'spec_helper'

describe GeoMagic::DistanceVector do
  before do
    @long_dist  = -0.3.km
    @lat_dist   = 0.05.km
  end

  context 'Distance vector' do
    subject { GeoMagic::DistanceVector.new @long_dist, @lat_dist }
  
    its(:long_distance) { should > 0 }
    its(:lat_distance)  { should > 0 }
    
    describe '#multiply' do    
      it "should multiply the radius distance and return new circle" do
        old_dist = subject.long_distance
        dvec = subject.multiply(0.5) 
        subject.long_distance.should == old_dist        
        dvec.long_distance.should < subject.long_distance
      end
    end

    describe '#multiply!' do
      it "should multiply the radius distance" do
        old_dist = subject.long_distance
        subject.multiply!(5) 
        subject.long_distance.should > old_dist
      end
    end
  end
end