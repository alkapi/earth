require 'spec_helper'
require 'earth/hospitality/commercial_building_energy_consumption_survey_response'

describe CommercialBuildingEnergyConsumptionSurveyResponse do
  describe "when importing data", :data_miner => true do
    before do
      Earth.init :hospitality, :load_data_miner => true, :skip_parent_associations => :true
    end
    
    it "imports all naics codes" do
      CommercialBuildingEnergyConsumptionSurveyResponse.run_data_miner!
    end
  end
  
  describe "verify imported data", :sanity => true do
    it { CommercialBuildingEnergyConsumptionSurveyResponse.count.should == 5215 }
    
    it { CommercialBuildingEnergyConsumptionSurveyResponse.where(:electricity_use      => nil).count.should == 0 }
    it { CommercialBuildingEnergyConsumptionSurveyResponse.where(:electricity_energy   => nil).count.should == 0 }
    it { CommercialBuildingEnergyConsumptionSurveyResponse.where(:natural_gas_use      => nil).count.should == 0 }
    it { CommercialBuildingEnergyConsumptionSurveyResponse.where(:natural_gas_energy   => nil).count.should == 0 }
    it { CommercialBuildingEnergyConsumptionSurveyResponse.where(:fuel_oil_use         => nil).count.should == 0 }
    it { CommercialBuildingEnergyConsumptionSurveyResponse.where(:fuel_oil_energy      => nil).count.should == 0 }
    it { CommercialBuildingEnergyConsumptionSurveyResponse.where(:district_heat_use    => nil).count.should == 0 }
    it { CommercialBuildingEnergyConsumptionSurveyResponse.where(:district_heat_energy => nil).count.should == 0 }
    
    it "should have room nights and fuel intensities per room night for lodging_records" do
      spot_check = CommercialBuildingEnergyConsumptionSurveyResponse.lodging_records.first
      spot_check.room_nights.should == 6205
      spot_check.natural_gas_per_room_night.should be_within(5e-6).of(2.37087)
      spot_check.natural_gas_per_room_night_units.should == 'cubic_metres_per_room_night'
    end
  end
  
  describe ".lodging_records" do
    it "should return only records representing Hotels, Motels, and Inns with no other activity" do
      lodging_records = CommercialBuildingEnergyConsumptionSurveyResponse.lodging_records
      lodging_records.map(&:detailed_activity).uniq.sort.should == ['Hotel', 'Motel or inn']
      lodging_records.map(&:first_activity).uniq.should == [nil]
      lodging_records.count.should == 192
    end
  end
end
