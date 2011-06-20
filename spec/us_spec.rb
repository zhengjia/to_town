require 'spec_helper'
require 'to_town/converter/us'
require 'to_town/data_migration'

describe "Us" do

  it "should create a migration record" do
    ToTown::DataMigration.all.length.should == 0
    ToTown::Converter::Us.run(dry = 1)
    ToTown::DataMigration.all.length.should == 1
    ToTown::DataMigration.first.filename.should == "Gaz_places_national.txt"
  end

end
