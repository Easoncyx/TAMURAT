Feature: Decision maker Features
  
  As a decision maker
  
  
Background:  Log in as a Decision maker
  Given I log in as a Decision maker
  Then I should see "Welcome to the TAMURAT"
  
  Scenario: Decision maker can see
    Given I am on Home page 
    Then I should see "Example DM1"