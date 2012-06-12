require 'spec_helper'
require 'earth/automobile/automobile_make_year'

describe AutomobileMakeYear do
  before :all do
    Earth.init :automobile, :load_data_miner => true
    require 'earth/acronyms'
  end
  
  describe 'import', :data_miner => true do
    it 'should import data' do
      AMY.run_data_miner!
      AMY.count.should == AMY.connection.select_value("SELECT COUNT(DISTINCT make_name, year) FROM #{AMMYV.quoted_table_name}")
    end
  end
  
  describe 'verify imported data' do
    it { AMY.where("fuel_efficiency > 0").count.should == AMY.count }
    it { AMY.find("Honda 2011").fuel_efficiency.should be_within(1e-4).of(13.34186) }
    it { AMY.find("Honda 2012").fuel_efficiency.should be_within(1e-5).of(12.17321) }
    
    it 'has proper weightings' do
      AMY.connection.select_values("SELECT DISTINCT year FROM #{AMY.quoted_table_name}").each do |year|
        AMY.where(:year => year).first.weighting.should == AutomobileYear.weighting(year)
      end
    end
  end
end