require 'spec_helper'

describe GeoMagic::Point::Random do
  describe '#move_random' do  
    it "should move point to a random locationwithin 5 km" do
      point = GeoMagic::Point.new -10, 20
      puts point.methods.sort.grep /mov/
      new_point = point.move_random 5.km
      puts point.inspect
      puts new_point.inspect
    end
  end
end