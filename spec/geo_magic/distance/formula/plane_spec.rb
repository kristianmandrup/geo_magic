require 'spec_helper'


describe GeoMagic::Distance::Plane do

  subject { GeoMagic::Distance::Plane }
  
  describe '#point_distance' do    
    before do
      @a = [45, 10].to_point
      @b = [42, 11].to_point
    end
    
    it 'should calculate the distance between points A and B' do
      dist = subject.point_distance @a, @b
      puts dist
    end
  end

  describe '#distance' do    
    before do
      @a = [45, 10]
      @b = [42, 11]
    end
    
    it 'should calculate the distance between points A and B' do
      dist = subject.distance [@a, @b].flatten
      puts dist
    end
  end
end

