Feature: Data import for AutomobileMakeYear
  As a data user
  I want to import MakeYear data
  So that I can perform year-based calculations
  
  Scenario: Successfully verifying that year is from 1985 to 2010
    Given a "AutomobileMakeYear" data import fetches results listed in "automobile_make_year_good"
    When a data import verifies "Year should be from 1985 to 2010"
    Then the verification should be successful
  
  Scenario: Successfully verifying that fuel efficiency is greater than zero
    Given a "AutomobileMakeYear" data import fetches results listed in "automobile_make_year_good"
    When a data import verifies "Fuel efficiency should be greater than zero"
    Then the verification should be successful
  
  Scenario: Successfully verifying that fuel efficiency units are kilometres per litre
    Given a "AutomobileMakeYear" data import fetches results listed in "automobile_make_year_good"
    When a data import verifies "Fuel efficiency units should be kilometres per litre"
    Then the verification should be successful
  
  Scenario: Failing to verify that year is from 1985 to 2010
    Given a "AutomobileMakeYear" data import fetches results listed in "automobile_make_year_bad"
    When a data import verifies "Year should be from 1985 to 2010"
    Then the verification should not be successful
  
  Scenario: Failing to verify that fuel efficiency is greater than zero
    Given a "AutomobileMakeYear" data import fetches results listed in "automobile_make_year_bad"
    When a data import verifies "Fuel efficiency should be greater than zero"
    Then the verification should not be successful
  
  Scenario: Failing to verify that fuel efficiency units are kilometres per litre
    Given a "AutomobileMakeYear" data import fetches results listed in "automobile_make_year_bad"
    When a data import verifies "Fuel efficiency units should be kilometres per litre"
    Then the verification should not be successful
