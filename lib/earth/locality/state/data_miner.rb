State.class_eval do
  data_miner do
    process "Start from scratch" do
      delete_all
    end
    
    # state names, FIPS codes, and postal abbreviations
    import 'the U.S. Census State ANSI Code file',
           :url => 'http://www.census.gov/geo/www/ansi/state.txt',
           :delimiter => '|',
           :select => proc { |record| record['STATE'].to_i < 60 } do
      key   'postal_abbreviation', :field_name => 'STUSAB'
      store 'fips_code',           :field_name => 'STATE'
      store 'name',                :field_name => 'STATE_NAME'
    end
    
    # census divisions
    import 'state census divisions from the U.S. Census',
           :url => 'http://www.census.gov/popest/about/geo/state_geocodes_v2009.txt',
           :skip => 8,
           :headers => ['Region', 'Division', 'State FIPS', 'Name'],
           :select => proc { |row| row['State FIPS'].to_i > 0 } do
      key   'fips_code', :field_name => 'State FIPS'
      store 'census_division_number', :field_name => 'Division'
    end
    
    # PADD
    import 'a list of state Petroleum Administration for Defense Districts',
           :url => 'http://spreadsheets.google.com/pub?key=t5HM1KbaRngmTUbntg8JwPA&gid=0&output=csv' do
      key   'postal_abbreviation', :field_name => 'State'
      store 'petroleum_administration_for_defense_district_code', :field_name => 'Code'
    end
    
    process 'ensure ZipCode is populated' do
      ZipCode.run_data_miner!
    end
    
    process 'derive population from ZipCode' do
      safe_find_each do |state|
        state.update_attributes! :population => state.zip_codes.sum(:population)
      end
    end
  end
end
