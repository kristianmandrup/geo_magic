require 'spec_helper'

describe GeoMagic::CircularRadius do
  describe '#new' do  
    let(:center) do
      {:lat => 40, :long => 11}
    end

    let(:distance) { 3.2 }
    
    it "should create a new circular radius" do
      circle = GeoMagic::CircularRadius.new center, distance
      puts circle.inspect
    end
  end
end