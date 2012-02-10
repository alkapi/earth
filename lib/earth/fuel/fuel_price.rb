class FuelPrice < ActiveRecord::Base
  self.primary_key = "name"
  
  belongs_to :fuel_type, :foreign_key => 'name' # weird
  
  col :name
  col :price, :type => :float
  col :price_units
end
