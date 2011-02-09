require 'spec_helper'

describe GeoMagic::RectangularRadius do
  describe '#new' do  
    let(:center) do
      {:lat => 40, :long => 11}
    end

    let(:vector_distance) do
      {:lat => 1.2, :long => 0.4}
    end
    
    it "should create a new rectangular radius" do
      rect = GeoMagic::RectangularRadius.new center, vector_distance
      puts rect.inspect
    end
  end
end