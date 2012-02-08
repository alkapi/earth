class FlightDistanceClass < ActiveRecord::Base
  self.primary_key = :name
  
  def self.find_by_distance(distance)
    first :conditions => arel_table[:min_distance].lteq(distance.to_f).and(arel_table[:max_distance].gt(distance.to_f))
  end
  
  col :name
  col :distance, :type => :float
  col :distance_units
  col :min_distance, :type => :float
  col :min_distance_units
  col :max_distance, :type => :float
  col :max_distance_units
end
