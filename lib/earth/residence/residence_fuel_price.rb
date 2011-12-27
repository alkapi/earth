require 'earth/locality'
class ResidenceFuelPrice < ActiveRecord::Base
  set_primary_key :row_hash
  
  extend CohortScope
  self.minimum_cohort_size = 5 # ? FIXME
  
  belongs_to :fuel, :class_name => 'ResidenceFuelType', :foreign_key => 'residence_fuel_type_name'
  belongs_to :locatable, :polymorphic => true
  
  col :row_hash
  col :residence_fuel_type_name
  col :year, :type => :integer
  col :month, :type => :integer
  col :price, :type => :float
  col :price_units
  col :price_description
  col :locatable_id
  col :locatable_type
  add_index [:price, :residence_fuel_type_name, :month, :year, :locatable_type, :locatable_id]
  add_index [:price, :residence_fuel_type_name]
end