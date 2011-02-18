Feature: Data import for BusFuel
  As a data user
  I want to import BusFuel data
  So that I can perform bus fuel-based calculations

  Scenario: Successfully verifying that fuel name is never missing
    Given a "BusFuel" data import fetches results listed in "bus_fuel_good"
    When a data import verifies "Fuel name should never be missing"
    Then the verification should be successful

  Scenario: Successfully verifying that energy content is greater than zero if present
    Given a "BusFuel" data import fetches results listed in "bus_fuel_good"
    When a data import verifies "Energy content should be greater than zero if present"
    Then the verification should be successful

  Scenario: Successfully verifying that ch4 emission factor is greater than zero if present
    Given a "BusFuel" data import fetches results listed in "bus_fuel_good"
    When a data import verifies "Ch4 emission factor should be greater than zero if present"
    Then the verification should be successful

  Scenario: Successfully verifying that n2o emission factor is greater than zero if present
    Given a "BusFuel" data import fetches results listed in "bus_fuel_good"
    When a data import verifies "N2o emission factor should be greater than zero if present"
    Then the verification should be successful

  Scenario: Successfully verifying that energy content units are megajoules per litre if present
    Given a "BusFuel" data import fetches results listed in "bus_fuel_good"
    When a data import verifies "Energy content units should be megajoules per litre if present"
    Then the verification should be successful

  Scenario: Successfully verifying that ch4 emission factor units are kilograms per kilometre if present
    Given a "BusFuel" data import fetches results listed in "bus_fuel_good"
    When a data import verifies "Ch4 emission factor units should be kilograms per kilometre if present"
    Then the verification should be successful

  Scenario: Successfully verifying that n2o emission factor units are kilograms per kilometre if present
    Given a "BusFuel" data import fetches results listed in "bus_fuel_good"
    When a data import verifies "N2o emission factor units should be kilograms per kilometre if present"
    Then the verification should be successful

  Scenario: Failling to verify that fuel name is never missing
    Given a "BusFuel" data import fetches results listed in "bus_fuel_bad"
    When a data import verifies "Fuel name should never be missing"
    Then the verification should not be successful

  Scenario: Failling to verify that energy content is greater than zero if present
    Given a "BusFuel" data import fetches results listed in "bus_fuel_bad"
    When a data import verifies "Energy content should be greater than zero if present"
    Then the verification should not be successful

  Scenario: Failing to verify that ch4 emission factor is greater than zero if present
    Given a "BusFuel" data import fetches results listed in "bus_fuel_bad"
    When a data import verifies "Ch4 emission factor should be greater than zero if present"
    Then the verification should not be successful

  Scenario: Failing to verify that n2o emission factor is greater than zero if present
    Given a "BusFuel" data import fetches results listed in "bus_fuel_bad"
    When a data import verifies "N2o emission factor should be greater than zero if present"
    Then the verification should not be successful

  Scenario: Failing to verify that energy content units are megajoules per litre if present
    Given a "BusFuel" data import fetches results listed in "bus_fuel_bad"
    When a data import verifies "Energy content units should be megajoules per litre if present"
    Then the verification should not be successful

  Scenario: Failing to verify that ch4 emission factor units are kilograms per kilometre if present
    Given a "BusFuel" data import fetches results listed in "bus_fuel_bad"
    When a data import verifies "Ch4 emission factor units should be kilograms per kilometre if present"
    Then the verification should not be successful

  Scenario: Failing to verify that n2o emission factor units are kilograms per kilometre if present
    Given a "BusFuel" data import fetches results listed in "bus_fuel_bad"
    When a data import verifies "N2o emission factor units should be kilograms per kilometre if present"
    Then the verification should not be successful

