class FuelRegionYear < ActiveRecord::Base
  set_primary_key :name
  
  data_miner do
    tap "Brighter Planet's region-specific annual fuel data", Earth.taps_server
  end
end
