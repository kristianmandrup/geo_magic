require 'spec_helper'

describe GeoMagic::PointsDistance do
  before do
    @a  =       [45.1, 11].to_point
    @b  =       [48, 11].to_point
    @center  =  [45, 11].to_point    

    GeoMagic::PointsDistance.new 5.km, [@a, @b].to_points
  end

  context 'Distance vector' do
    subject { GeoMagic::PointsDistance.new 5.km, [@a, @b].to_points }
  
    describe '#near' do
      it "should only select points near center" do
        subject.near(@center).should include(@a)
      end
    end
  end
end

