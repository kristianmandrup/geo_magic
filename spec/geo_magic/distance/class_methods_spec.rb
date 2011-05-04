require 'spec_helper'

describe GeoMagic::Distance do
  before do
    @long1 = -104.88544
    @lat1 = 39.06546

    @long2 = -104
    @lat2 = @lat1
  end

  subject { GeoMagic::Distance }
  
  context 'default distance algorithm' do
    it "calculates distance using 2 array args" do
      p1 = [@long1, @lat1]
      p2 = [@long2, @lat2]
      dist = subject.calculate p1, p2
      puts dist    
    end

    it "calculates distance using 4 number args" do
      dist = subject.calculate @long1, @lat1, @long2, @lat2
      km_dist = dist[:km]
      puts dist
      puts "km: #{km_dist}"
    end

    it "calculates distance using 2 hash args" do  
      p1 = {:long => @long1, :lat => @lat1}
      p2 = {:long => @long2, :lat => @lat2}
      dist = subject.calculate p1, p2
      pp dist.class
      pp dist.in_meters
      km_dist = dist[:km]
      pp dist
      puts dist.in_feet
      puts "km: #{km_dist}"
    end
  end
end