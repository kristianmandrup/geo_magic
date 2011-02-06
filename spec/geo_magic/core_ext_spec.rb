require 'spec_helper'

describe Symbol do
  it "should return radians ratio" do
    km_radians = :km.radians_ratio
    puts km_radians
  end
end

describe String do
  it "should return radians ratio" do
    km_radians = 'km'.radians_ratio
    puts km_radians
  end
end