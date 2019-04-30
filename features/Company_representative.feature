Feature: Company Representative Features
  
  as a Company Representative
  
  
Background:  Log in as a Company Representative
  Given I log in as a Company Representative
  Then I should see "Welcome to the TAMURAT"
  
  Scenario: Company Representative can see Home page
    Given I am on Home page
    Then I should see "Example CR1"