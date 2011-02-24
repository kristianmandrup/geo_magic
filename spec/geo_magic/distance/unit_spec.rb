require 'spec_helper'

describe GeoMagic::Distance::Unit do
  context "5 km distance" do  

    subject { GeoMagic::Distance::Unit.new :km, 5 }

    its(:number) { should > 0 }
    its(:radians_ratio) { should > 0 }
  end
end