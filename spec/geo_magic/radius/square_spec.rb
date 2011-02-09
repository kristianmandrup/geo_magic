require 'spec_helper'

describe GeoMagic::SquareRadius do
  describe '#new' do  
    let(:center) do
      {:lat => 40, :long => 11}
    end

    let(:distance) { 0.5.km }
    
    it "should create a new square radius" do
      square = GeoMagic::SquareRadius.new center, distance
      puts square.inspect
    end
  end
end