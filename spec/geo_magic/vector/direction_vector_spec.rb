require 'spec_helper'

describe GeoMagic::DirectionVector do
  context 'A point 0.1 radian vector to East' do
    before :each do      
      @vector = GeoMagic::DirectionVector.new 0.1, :east
    end

    describe '#direction' do
      it 'should be east' do
        @vector.direction.should == :east
      end
    end

    describe '#distance' do
      it 'should be a GeoMagic::Distance' do
        @vector.distance.should be_a(GeoMagic::Distance)
      end
    end
  end

  context 'A point 0.1 radian vector to NW' do
    before :each do      
      @vector = GeoMagic::DirectionVector.new 0.1, :NW
    end

    describe 'Class' do
      it "is a GeoMagic::PointVector" do
        @vector.should be_a(GeoMagic::DirectionVector)
      end
    end
    
    describe '#to_point_vector' do
      it 'should work' do
        @vector.to_point_vector
      end
    end
  end
end
