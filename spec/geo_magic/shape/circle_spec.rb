require 'spec_helper'

describe GeoMagic::Circle do
  context 'a 5.km circle' do
    before :each do
      @circle = GeoMagic::Circle.new 5.km
      @radius = GeoMagic::Radius::Circular.create_from @circle
    end

    describe 'Class' do
      it "is a GeoMagic::Circle" do
        @circle.should be_a(GeoMagic::Circle)
      end
    end
    
    describe '#create_within' do
      it "creates a new circle within the radius of the circle" do
        @circle.create_within @radius
      end
    end    
  end
end