Feature: Data import for AutomobileFuelType
  As a data user
  I want to import AutomobileFuelType data
  So that I can perform fuel type-based calculations

  Scenario: Successfully verifying that annual distance and emission factor > 0
    Given a "AutomobileFuelType" data import fetches results listed in "automobile_fuel_type_good"
    When a data import verifies "Annual distance and emission factor should be greater than zero"
    Then the verification should be successful

  Scenario: Successfully verifying that annual distance units are kilometres
    Given a "AutomobileFuelType" data import fetches results listed in "automobile_fuel_type_good"
    When a data import verifies "Annual distance units should be kilometres"
    Then the verification should be successful

  Scenario: Successfully verifying that emission factor units are never missing
    Given a "AutomobileFuelType" data import fetches results listed in "automobile_fuel_type_good"
    When a data import verifies "Emission factor units should never be missing"
    Then the verification should be successful

  Scenario: Failing to verify that annual distance and emission factor > 0
    Given a "AutomobileFuelType" data import fetches results listed in "automobile_fuel_type_bad"
    When a data import verifies "Annual distance and emission factor should be greater than zero"
    Then the verification should not be successful

  Scenario: Failing to verify that annual distance units are kilometres
    Given a "AutomobileFuelType" data import fetches results listed in "automobile_fuel_type_bad"
    When a data import verifies "Annual distance units should be kilometres"
    Then the verification should not be successful

  Scenario: Failing to verify that emission factor units are never missing
    Given a "AutomobileFuelType" data import fetches results listed in "automobile_fuel_type_bad"
    When a data import verifies "Emission factor units should never be missing"
    Then the verification should not be successful
