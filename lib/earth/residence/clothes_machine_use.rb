class ClothesMachineUse < ActiveRecord::Base
  set_primary_key :name
  
  has_many :residential_energy_consumption_survey_responses

  force_schema do
    string 'name'
    float  'annual_energy_from_electricity_for_clothes_driers'
    string 'annual_energy_from_electricity_for_clothes_driers_units'
  end
end
