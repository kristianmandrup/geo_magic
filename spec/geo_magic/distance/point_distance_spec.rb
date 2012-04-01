require 'spec_helper'

describe GeoMagic::PointDistance do
  before do
    @a  =       [45.1, 11].to_point
    @b  =       [48, 11].to_point
    @center  =  [45, 10].to_point        
  end

  context '5km from point A and B' do
    before do 
      @a5 = GeoMagic::PointDistance.new 5.km, @a
      @b3 = GeoMagic::PointDistance.new 3.km, @b
    end

    describe '#distance' do
      it "should be that A5 distance is 5 km" do
        @a5.distance.should == 5.km
      end

      it "should be that A5 reference point is A" do
        @a5.point.should == @a
      end

      it "should be that B3 distance is 3 km" do
        @b3.distance.should == 3.km
      end
    end
  
    describe '#of' do
      it "should be that A is within 5km of center" do
        @a5.of(@center).should be_true
      end

      it "should NOT be that B is within 5km of center" do
        @b3.of(@center).should_not be_true
      end
      
      it "should be that A is within 5km of point A" do
        @a5.of(@a).should be_true
      end      
    end
  end
end

