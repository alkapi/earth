require 'spec_helper'
require 'earth/electricity/electric_utility'

describe ElectricUtility do
  describe 'Electric utility data', :data_miner => true do
    before do
      Earth.init :electricity, :load_data_miner => true, :skip_parent_associations => :true
      ElectricUtility.run_data_miner!
    end
    
    it 'should include all U.S. utilities' do
      ElectricUtility.count.should == 3266
    end

    it 'should include, specifically, MG&E' do
      ElectricUtility.find(11479).name.should == 'Madison Gas & Electric Co'
    end
  end
end
