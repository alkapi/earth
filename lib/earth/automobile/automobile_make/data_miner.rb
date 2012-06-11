AutomobileMake.class_eval do
  data_miner do
    process "Start from scratch" do
      delete_all
    end
    
    process "Ensure AutomobileMakeYear is populated" do
      AutomobileMakeYear.run_data_miner!
    end
    
    process "Derive manufacturer names from AutomobileMakeYear" do
      ::Earth::Utils.insert_ignore(
        :src => AutomobileMakeYear,
        :dest => AutomobileMake,
        :cols => { :make_name => :name }
      )
    end
    
    process "Derive fuel efficiency from AutomobileMakeYear" do
      find_each do |make|
        make.fuel_efficiency = make.make_years.weighted_average(:fuel_efficiency)
        make.fuel_efficiency_units = make.make_years.first.fuel_efficiency_units
        make.save!
      end
    end
  end
end

# leave this for later if we need it
# SUBSIDIARIES = {
#   'Chevrolet' => 'GM',
#   'Pontiac' => 'GM',
#   'Audi' => 'Volkswagen',
#   'Dodge' => 'Chrysler',
#   'Lincoln' => 'Ford',
#   'Plymouth' => 'Chrysler',
#   'Buick' => 'GM',
#   'Cadillac' => 'GM',
#   'Merkur' => 'Ford',
#   'Oldsmobile' => 'GM',
#   'GMC' => 'GM',
#   'Bentley' => 'Rolls-Royce', # currently owned by Volkswagen, but a Flying Spur is hardly a rebranded Passat
#   'Acura' => 'Honda',
#   'Land Rover' => 'Ford',
#   'Eagle' => 'Chrysler',
#   'Geo' => 'GM',
#   'Laforza' => 'Ford',
#   'Infiniti' => 'Nissan',
#   'Lexus' => 'Toyota',
#   'Saturn' => 'GM',
#   'Mercury' => 'Ford',
#   'Alpina' => 'BMW',
#   'Mini' => 'BMW',
#   'Maybach' => 'Mercedes',
#   'Hummer' => 'GM'
# }
