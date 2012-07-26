AutomobileTypeFuelYearControl.class_eval do
  data_miner do
    import "automobile type fuel year control data derived from the 2010 EPA GHG Inventory",
           :url => "file://#{Earth::DATA_DIR}/automobile/annual_emission_controls.csv" do
      key   'name'
      store 'type_name'
      store 'fuel_family'
      store 'year'
      store 'control_name'
      store 'type_fuel_control_name', :synthesize => proc { |row| [row['type_name'], row['fuel_family'], row['control_name']].join(' ') }
      store 'total_travel_percent'
    end
  end
end
