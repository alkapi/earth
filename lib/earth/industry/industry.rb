class Industry < ActiveRecord::Base
  set_primary_key :naics_code
  
  has_many :industries_product_lines, :foreign_key => 'naics_code'
  has_many :product_lines, :through => :industries_product_lines
  has_many :industries_sectors, :foreign_key => 'naics_code'
  has_many :sectors, :through => :industries_sectors
  
  data_miner do
    tap "Brighter Planet's industry data", Earth.taps_server
  end
end
