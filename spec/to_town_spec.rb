require 'spec_helper'
require 'to_town'
require 'to_town/point'

describe "ToTown" do

  it "should have a check class method" do
    ToTown.should respond_to :check
  end

  it "should return a list of points" do
    ToTown::Point.create(:name => "name1", :latlng => [50,51] )
    points = ToTown.check(50,50)
    points.length.should == 1
    points.first.name.should == "name1"
  end

end
