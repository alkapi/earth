class ZipCode < ActiveRecord::Base
  set_primary_key :name
  
  belongs_to :egrid_subregion, :foreign_key => 'egrid_subregion_abbreviation'
  belongs_to :climate_division, :foreign_key => 'climate_division_name'
  belongs_to :state, :foreign_key => 'state_postal_abbreviation'
#  has_one :census_division, :through => :state
#  has_one :census_region, :through => :state
  has_many :residences

  index :name
  
  acts_as_mappable :default_units => :miles,  # FIXME imperial
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  def description_with_state_postal_abbreviation
    [ description, state.andand.postal_abbreviation ].select(&:present?).join ', '
  end
  
  def description_with_state_name
    [ description, state.andand.name ].select(&:present?).join ', '
  end
  
  def set_latitude_and_longitude
    return if latitude.present? and longitude.present?
    a = Geokit::Geocoders::YahooGeocoder.geocode name
    update_attributes! :latitude => a.lat, :longitude => a.lng
  end
  
  data_miner do
    tap "Brighter Planet's sanitized zip codes", TAPS_SERVER
    
    process "pull dependencies" do
      run_data_miner_on_belongs_to_associations
    end
  end
end
