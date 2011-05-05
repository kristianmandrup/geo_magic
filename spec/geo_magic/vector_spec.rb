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

    describe 'class methods' do
      describe '#create_at' do
        it "should create a vector from a point and another vector" do
          v2 = GeoMagic::Vector.create_at @a, @vector
          v2.should be_a(GeoMagic::Vector)
        end
      end
    end

    describe '#distance' do
      it "is has a distance" do
        @vector.distance.should be_a(GeoMagic::Distance)
        @vector.distance.in_meters.should > 500
      end
    end

    describe '#lat_factor' do
      it "is has a lat_factor of 2" do
        @vector.lat_factor.should >= 2
      end
    end    

    describe '#length' do
      describe ':latitude' do
        it "is has a latitude length of ..." do
          @vector.length(:latitude).in_km.should >= 0.5
        end
      end

      describe ':longitude' do
        it "is has a longitude length of ..." do
          @vector.length(:longitude).in_km.should >= 0.5
        end
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

      it "is has a longitude distance < 15" do
        long_dist = @vector.vector_distance.long_distance.km
        # puts long_dist
        long_dist.should < 15
      end
    end   
  end
end