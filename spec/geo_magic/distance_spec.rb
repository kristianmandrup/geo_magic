require 'spec_helper'

describe GeoMagic::Distance do
  before do  
    @a = [45.1, 11].to_point
    @b = [45.1, 11.1].to_point
    @c = [48.1, 12.1].to_point    
    @center = [45, 11].to_point
    @points = [@a, @b, @c]
  end

  it "should be that 5km is less than 7000m" do
    (5.km < 7000.meters).should be_true
  end

  subject { 5.km }

  describe 'Select subset of points within distance' do
    describe '#select_all #near' do 
      it "should select points near center" do      
        res = subject.select_all(@points).near(@center)
        res.should include(@a)
        res.should_not include(@c)
      end
    end
  end

  describe 'Reject subset of points within distance' do
    describe '#reject_all' do 
      it "should select points near center" do            
        res = subject.reject_all(@points).near(@center)
        res.should_not include(@a)
        res.should include(@c)
      end
    end
  end
end