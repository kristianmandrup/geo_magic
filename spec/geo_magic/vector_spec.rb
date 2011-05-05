require 'spec_helper'

RAD_KM_LAT45 = GeoMagic::Distance.radian_radius[:km] * 2

describe GeoMagic::Vector do
  context 'an almost 1 radian vector' do
    before :each do
      @a      = [45.1, 11].to_point
      @b      = [46, 11.4].to_point
      @vector = GeoMagic::Vector.new @a, @b
    end

    describe 'Class' do
      it "is a GeoMagic::Vector" do
        @vector.should be_a(GeoMagic::Vector)
      end
    end

    describe '#vector_distance' do
      it "is has a vector_distance" do
        @vector.vector_distance.should be_a(GeoMagic::Distance::Vector)
      end

      it "is has a latitude distance < #{RAD_KM_LAT45}" do
        lat_dist = @vector.vector_distance.lat_distance.km
        lat_dist.should < RAD_KM_LAT45
      end
    end   
  end
end