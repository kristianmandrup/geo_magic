require 'spec_helper'

describe GeoMagic::Distance do
  before do  
    a = [45.1, 11].to_point
    b = [45.1, 11.1].to_point
    c = [48.1, 12.1].to_point    
    @center = [45, 11].to_point
    @points = [a, b, c]
  end

  subject { 5.km }

  describe 'Select subset of points within distance' do
    describe '#select_within' 
      subject.select_within @points, @center
    end

    describe '#select_all #near' 
      subject.select_all(@points).near(@center)
    end
  end

  describe 'Reject subset of points within distance' do
    describe '#reject_within' 
      subject.reject_near @points, @center
    end

    describe '#reject_all #within' 
      subject.reject_all(@points).near(@center)
    end
  end
end