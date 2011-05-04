require 'spec_helper'

describe GeoMagic::Vector do
  context 'a 5.km distance' do
    before :each do
      @dist = 5.km
    end

    describe 'Class' do
      it "is a GeoMagic::Distance" do
        @dist.should be_a(GeoMagic::Distance)
      end
    end
  end
end