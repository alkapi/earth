class IndustriesProductLines < ActiveRecord::Base
  set_primary_key :row_hash
  
  belongs_to :industry,     :foreign_key => 'naics_code'
  belongs_to :product_line, :foreign_key => 'ps_code'
  
  data_miner do
    tap "Brighter Planet's industry to product line dictionary", Earth.taps_server
  end
end
