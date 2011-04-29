class FlightSegment < ActiveRecord::Base
  set_primary_key :row_hash
  
  extend CohortScope
  self.minimum_cohort_size = 1
  
  # If airport iata code is present, associate with a single airport
  belongs_to :origin_airport,      :foreign_key => 'origin_airport_iata_code',      :primary_key => 'iata_code', :class_name => 'Airport'
  belongs_to :destination_airport, :foreign_key => 'destination_airport_iata_code', :primary_key => 'iata_code', :class_name => 'Airport'
  
  # If airport iata code is missing, associate with all airports in a city
  has_many :origin_city_airports,      :foreign_key => 'city', :primary_key => 'origin_airport_city',      :class_name => 'Airport'
  has_many :destination_city_airports, :foreign_key => 'city', :primary_key => 'destination_airport_city', :class_name => 'Airport'
  
  # Associate with Airline based on airline name
  belongs_to :airline, :foreign_key => 'airline_name', :primary_key => 'name'
  
  # Associate with all aircraft that fuzzily match the flight segment's aircraft_description
  has_many :fuzzy_aircraft_matches, :foreign_key => 'search_description', :primary_key => 'aircraft_description'
  has_many :aircraft, :through => :fuzzy_aircraft_matches, :foreign_key => 'search_description', :primary_key => 'aircraft_description'
  
  falls_back_on :distance      => lambda { weighted_average(:distance,      :weighted_by => :passengers) }, # 2077.1205         data1 10-12-2010
                :seats         => lambda { weighted_average(:seats,         :weighted_by => :passengers) }, # 144.15653537046   data1 10-12-2010
                :load_factor   => lambda { weighted_average(:load_factor,   :weighted_by => :passengers) }, # 0.78073233770097  data1 10-12-2010
                :freight_share => lambda { weighted_average(:freight_share, :weighted_by => :passengers) }  # 0.022567224170157 data1 10-12-2010
  
  data_miner do
    tap "Brighter Planet's sanitized flight segment data", Earth.taps_server
  end
end
