require 'spec_helper'

describe GeoMagic::PointsDistance do
  before do
    @a  =       [45.1, 11].to_point
    @b  =       [48, 11].to_point
    @center  =  [45, 11].to_point    

    GeoMagic::PointsDistance.new 5.km, [@a, @b].to_points
  end

  context 'Distance vector' do


    describe '#near' do
      describe 'select' do
        subject { GeoMagic::PointsDistance.new 5.km, [@a, @b].to_points, :select }
        
        it "should only select points near center" do
          res = subject.near(@center)
          res.should include(@a)
          res.should_not include(@b)
        end
      end

      describe 'reject' do
        subject { GeoMagic::PointsDistance.new 5.km, [@a, @b].to_points, :reject }
        
        it "should only select points near center" do
          res = subject.near(@center)
          res.should_not include(@a)
          res.should include(@b)
        end
      end
    end
  end
end

