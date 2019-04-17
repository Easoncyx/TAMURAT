Feature: Decision maker Features
  
  As a decision maker
  
  
Background:  Log in as a Decision maker
  Given I log in as a Decision maker
  Then I should see "Welcome to the TAMURAT"
  
  Scenario: Decision maker can see Home page
    Given I am on Home page 
    Then I should see "Example DM1"
    
  Scenario: Decision maker can management all questions
    Given I am on All question page
    Then I should see "All Question"
    # Category create/edit
    Given I edit the first category into "pickle-rick"
    Then I should see "pickle-rick was successfully updated."
    Given I create a new category "pickle-morty"
    Then I should see "pickle-morty was successfully created."
    # Subcategory create/edit
    Given I click link "pickle-rick"
    Then I should see "Business_1"
    Given I edit subcategory "Business_1" into "pickle-rick_1"
    Then I should see "pickle-rick_1 was successfully updated."
    Then I should see "Weight_sum = 9.7"
    Then I should see "pickle-rick_1"
    Given I create a new subcategory "pickle-rick_4"
    Then I should see "pickle-rick_4 was successfully created."
    Then I should see "pickle-rick_4"
    # Question create/edit
    Given I click link "pickle-rick_1"
    Then I should see "Business_1_q1"
    Given I edit question "Business_1_q1" into "pickle-rick_1_q1"
    Then I should see "pickle-rick_1_q1 was successfully updated."
    Then I should see "pickle-rick_1_q1"
    Given I create a new question "pickle-rick_1_q4"
    Then I should see "pickle-rick_1_q4 was successfully created."
    Then I should see "pickle-rick_1_q4"
    # Invalid input
    Given I input invalid in "Weight"
    Then I should see "Weight Invalid, you need to type a float."
    
  Scenario: Decision maker can partially manage assigned scenarios
    Given I am on All Scenarios page
    Then I should see "All Scenarios"
    Then I should not see "pickle-rick"
    # Admin assign a scenario to Example DM1
    Given I log out
    Given I log in as an Admin
    Given I am on All Scenarios page
    Given I create a new scenario "pickle-rick"
    Then I should see "Scenario created!"
    Then I should see "pickle-rick"
    Then I should see "This is a description for scenario"
    Given I click "Assign" of scenario "pickle-rick"
    Then I should see "All Decision Makers"
    Given I click "Assign" of "Example DM1" and "Exmaple DM2"
    Then I should see "Successfully Assigned!"
    # Log as Example DM1 again
    Given I log out
    Given I log in as a Decision maker
    Given I am on All Scenarios page
    Then I should see "pickle-rick"
    Then I should see "This is a description for scenario"
    # Create scenario
    Given I create a new scenario "pickle-morty"
    Then I should see "Scenario created!"
    Then I should see "pickle-morty"
    Then I should see "This is a description for scenario (DM)"
    # Related decision makers
    Given I click link "pickle-rick"
    Then I should see "Related decision makers"
    Then I should see "Example DM1"
    Then I should see "Example DM2"
    # Decision maker cannot delete scenarios
    Given I am on All Scenarios page
    Then I should not see "Delete"
    Then I should not see "delete"
    Then I should not see "Assign"
    Then I should not see "assign"
    
    
  Scenario: Help page
    Given I am on Help page
    Then I should see "Help"
    Then I should see "Contact the Team TreeNewBee @ TAMU for help."
    
  Scenario: Log out
    Given I log out
    Then I should see "Welcome to the TAMURAT"