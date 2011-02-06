require 'spec_helper'

describe 'Core extensions' do
  describe Symbol do
    it "should return radians ratio" do
      km_radians = :km.radians_ratio
      km_radians.should > 111
    end
  end

  describe String do
    it "should return radians ratio" do
      km_radians = 'km'.radians_ratio
      km_radians.should > 111
    end
  end

  describe Fixnum do
    it "should return distance" do
      km_dist = 5.km
      km_dist[:km].number.should > 0
    end
  end

  describe Float do
    it "should return distance" do
      km_dist = 5.2.km
      km_dist[:km].number.should > 0
    end
  end
end