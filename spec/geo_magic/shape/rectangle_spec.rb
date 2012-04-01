require 'spec_helper'

describe GeoMagic::Rectangle do
  context 'a 5.km circle' do
    before :each do
      @up_left    = [1, 1].to_point
      @up_right   = [3, 1].to_point
      @low_right  = [3, 3].to_point      
      @low_left   = [1, 3].to_point      
            
      @rect = GeoMagic::Rectangle.new @up_left, @low_right
      @radius = GeoMagic::Radius::Rectangular.create_from @rect      
    end

    describe 'Class' do
      it "is a GeoMagic::Rectangle" do
        @rect.should be_a(GeoMagic::Rectangle)
      end
    end

    describe '#create_within' do
      it "creates a new rectangle within the radius of the rectangle" do        
        @rect.create_within @radius
      end
    end

    describe '#contains? and #overlaps?' do
      it "determines if the point is contained by the rectangle" do
        inside_point = GeoMagic::Point.new(@rect.p0).move(0.1, 0.1) 
        outside_point = GeoMagic::Point.new(@rect.p0).move(-0.1, 0.1) 
        @rect.contains?(inside_point).should be_true
        @rect.overlaps?(inside_point).should be_true
        @rect.contains?(outside_point).should be_false
      end
    end

    describe '#vector' do
      it "should return a vector spanning the points that create the shape" do
        @rect.vector.should be_a(GeoMagic::Vector)
      end
    end

    describe '#point_a=' do
      it "should reset point_a and all calculated attributes" do
        old_ul = @rect.upper_left
        @rect.point_a = @rect.point_a.move(0.1, 0.1) 
        # upper left was invalidated and must be recalculated
        @rect.upper_left.should != old_ul
      end
    end

    describe '#point_b=' do
      it "should reset point_b and all calculated attributes" do
        old_ul = @rect.upper_left
        @rect.point_b = @rect.point_b.move(-0.1, -0.1) 
        # upper left was invalidated and must be recalculated
        @rect.upper_left.should != old_ul
      end
    end    

    describe '#upper_left' do
      it "should reset point_b and all calculated attributes" do
        @rect.upper_left.should == @up_left
      end
    end
    
    describe '#upper_right' do
      it "should reset point_b and all calculated attributes" do
        @rect.upper_right.should == @up_right
      end
    end    

    describe '#lower_left' do
      it "should reset point_b and all calculated attributes" do
        @rect.lower_left.should == @low_left
      end
    end
    
    describe '#lower_right' do
      it "should reset point_b and all calculated attributes" do
        @rect.lower_right.should == @low_right
      end
    end    
    
    # describe 'cool dsl' do
    #   it "should reset point_b and all calculated attributes" do
    #     @rect = GeoMagic::Rectangle.new @low_left, 5.km.from(@low_left, :NW)
    #     @rect.expand(10.km, :west)      
    #   end        
    # end
  end
end