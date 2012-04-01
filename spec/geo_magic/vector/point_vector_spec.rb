require 'spec_helper'

describe GeoMagic::PointVector do
  context 'A point vector' do
    before :each do
      @a      = [45.1, 11].to_point
      @b      = [46, 11.4].to_point
      @vector = GeoMagic::PointVector.new @a, @b
    end

    describe 'Class' do
      it "is a GeoMagic::PointVector" do
        @vector.should be_a(GeoMagic::PointVector)
      end
    end
  end
end
