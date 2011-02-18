class BusFuel < ActiveRecord::Base
  set_primary_key :name
  
  belongs_to :fuel, :foreign_key => 'fuel_name'
  has_many :year_controls, :class_name => 'BusFuelYearControl', :foreign_key => 'bus_fuel_name'
  
  data_miner do
    tap "Brighter Planet's sanitized bus fuel data", Earth.taps_server
    
    process "Pull dependencies" do
      run_data_miner_on_belongs_to_associations
    end
  end
  
  def latest_year_controls
    year_controls.where(:year => year_controls.maximum('year'))
  end
end
