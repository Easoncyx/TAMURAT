Feature: Validator Features
  
  as a Validatoralid
  
  
Background:  Log in as a Validator
  Given I log in as a Validator
  Then I should see "Welcome to the TAMURAT"
  
  Scenario: Admin can see all users list
    Given I am on Home page
    Then I should see "Example VA1"
  