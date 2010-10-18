AircraftBtsAircraftType.class_eval do
  data_miner do
    schema Earth.database_options do
      string 'row_hash'
      string 'icao_code'
      string 'bts_aircraft_type_code'
    end
    
    import 'pre-determined matches between aircraft and bts_aircraft_types',
           :url => 'https://spreadsheets.google.com/pub?key=0AoQJbWqPrREqdGhveHUxLWgzZmhZV1BfUGc2Nmg1S1E&hl=en&single=true&gid=0&output=csv' do
      key 'row_hash'
      store 'icao_code'
      store 'bts_aircraft_type_code'
    end
  end
end
