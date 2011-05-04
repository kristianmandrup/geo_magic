require 'spec_helper'

describe GeoMagic::Rectangle do
  context 'a 5.km circle' do
    before :each do
      @rect = GeoMagic::Square.new @center, 5.km.nw_of(@center)
    end

    describe 'Class' do
      it "is a GeoMagic::Square" do
        @rect.should be_a(GeoMagic::Square)
      end
    end
  end
end