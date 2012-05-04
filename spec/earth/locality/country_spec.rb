# encoding: UTF-8

require 'spec_helper'
require 'earth/locality/country'

describe Country do
  describe 'import', :data_miner => true do
    before do
      Earth.init :locality, :load_data_miner => true, :skip_parent_associations => :true
    end
    
    it 'should import data' do
      Country.run_data_miner!
    end
  end
  
  describe 'verify imported data', :sanity => true do
    it 'should have all the data' do
      Country.all.count.should == 249
    end
    it 'uses UTF-8 encoding' do
      Country.find('AX').name.should == "Åland Islands"
      Country.find('CI').name.should == "Côte d'Ivoire"
    end
    
    it 'has degree day data for 175 countries' do
      Country.where('heating_degree_days IS NOT NULL AND cooling_degree_days IS NOT NULL').count.should == 173
    end
    
    it 'has valid electricity emission factor and electricity loss factor for most countries' do
      Country.where('electricity_emission_factor IS NOT NULL').count.should == 136
      Country.where(:electricity_emission_factor_units => 'kilograms_co2e_per_kilowatt_hour').count.should == 136
      Country.where('electricity_loss_factor IS NOT NULL').count.should == 136
      
      Country.minimum(:electricity_emission_factor).should >= 0.0
      Country.minimum(:electricity_loss_factor).should >= 0.0
      Country.maximum(:electricity_loss_factor).should < 0.3
      
      us = Country.united_states
      us.electricity_emission_factor.should be_within(0.00001).of(0.58946)
      us.electricity_emission_factor_units.should == 'kilograms_co2e_per_kilowatt_hour'
      us.electricity_loss_factor.should be_within(0.001).of(0.062)
      
      uk = Country.find 'GB'
      uk.electricity_emission_factor.should be_within(0.00001).of(0.51020)
      uk.electricity_emission_factor_units.should == 'kilograms_co2e_per_kilowatt_hour'
      uk.electricity_loss_factor.should be_within(0.001).of(0.073)
    end
    
    it 'has fallback electricity emission factor and electricity loss factor' do
      fallback = Country.fallback
      fallback.electricity_emission_factor.should be_within(0.00001).of(0.62609)
      fallback.electricity_emission_factor_units.should == 'kilograms_co2e_per_kilowatt_hour'
      fallback.electricity_loss_factor.should be_within(0.001).of(0.096)
    end
    
    it 'has lodging data for the US' do
      us = Country.united_states
      us.lodging_occupancy_rate.should be_within(0.001).of(0.601)
      us.lodging_natural_gas_intensity.should be_within(0.00001).of(1.93316)
      us.lodging_natural_gas_intensity_units.should == 'cubic_metres_per_occupied_room_night'
    end
  end
  
  describe '.united_states' do
    it 'should return the United States' do
      Country.united_states.should == Country.find('US')
    end
  end
end
