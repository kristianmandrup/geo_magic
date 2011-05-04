require 'spec_helper'

describe GeoMagic::Rectangle do
  context 'a 5.km circle' do
    before :each do
      @rect = GeoMagic::Rectangle.new @center, 5.km.from(@center, :NW).expand(10.km, :west)
    end

    describe 'Class' do
      it "is a GeoMagic::Rectangle" do
        @rect.should be_a(GeoMagic::Rectangle)
      end
    end
  end
end