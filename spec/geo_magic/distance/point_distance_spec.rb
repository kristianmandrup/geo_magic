require 'spec_helper'

describe GeoMagic::PointDistance do
  before do
    @a  =       [45.1, 11].to_point
    @b  =       [48, 11].to_point
    @center  =  [45, 11].to_point        
  end

  context '5km from point A and B' do
    before do 
      a5 = GeoMagic::PointDistance.new 5.km, @a
      b5 = GeoMagic::PointDistance.new 5.km, @b
    end
  
    describe '#of' do
      it "should be that A is within 5km of center" do
        a5.of(@center).should be_true
      end

      it "should NOT be that B is within 5km of center" do
        b5.of(@center).should_not be_true
      end
    end
  end
end

