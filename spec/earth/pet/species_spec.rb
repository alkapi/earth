require 'spec_helper'

describe 'Species' do
  describe 'fallback' do
    describe 'marginal_dietary_requirement' do
      it 'should return 0 when there is no data' do
        Earth.init :pet, :load_data_miner => true, :skip_parent_associations => :true
        Species.delete_all
        Species.fallback.marginal_dietary_requirement.should == 0
      end
    end
  end
end
