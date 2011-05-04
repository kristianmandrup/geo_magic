require 'spec_helper'

describe GeoMagic::Circle do
  context 'a 5.km circle' do
    before :each do
      @circle = GeoMagic::Circle.new 5.km
    end

    describe 'Class' do
      it "is a GeoMagic::Circle" do
        @circle.should be_a(GeoMagic::Circle)
      end
    end
  end
end