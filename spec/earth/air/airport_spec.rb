require 'spec_helper'
require 'earth/air/airport'

describe Airport do
  describe "when importing data", :data_miner => true do
    before do
      Earth.init :air, :load_data_miner => true, :skip_parent_associations => :true
    end
    
    it "imports all airports" do
      Airport.run_data_miner!
    end
  end
  
  describe "verify imported data", :sanity => true do
    it "should have all the data" do
      Airport.count.should == 5324
    end
    
    it "should have name" do
      Airport.where(:name => nil).count.should == 0
    end
    
    it "should have city" do
      Airport.where(:city => nil).count.should == 0
    end
    
    it "should have country code" do
      Airport.where(:country_iso_3166_code => nil).count.should == 0
    end
    
    it "should have lat/lng" do
      Airport.where(:latitude => nil).count.should == 0
      Airport.where(:longitude => nil).count.should == 0
    end
    
    # FIXME TODO check for duplicate cities in same country
  end
end
