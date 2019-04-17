Feature: Validator Features
  
  as a Validatoralid
  
  
Background:  Log in as a Validator
  Given I log in as a Validator
  Then I should see "Welcome to the TAMURAT"
  
  Scenario: Validator can see Home page
    Given I am on Home page
    Then I should see "Example VA1"
    
  Scenario: Validator can see scales
    Given I am on Scales page
    Then I should see "Scales"
    # Filter 
    When I uncheck the following category: Security, Finance
    When I press "Refresh"
    Then I should not see "S trust level 0"
    Then I should not see "F trust level 0"
    When I check the following category: Security, Finance
    When I press "Refresh"
    Then I should see "S trust level 0"
    # Validator cannot edit/create/delte scales
    Then I should not see "Handler"
    Then I should not see "Edit"
    Then I should not see "Destroy"
    
  Scenario: Validator can validate companies
    # TODO
  
  
  
  
  
  
  
  Scenario: Help page
    Given I am on Help page
    Then I should see "Help"
    Then I should see "Contact the Team TreeNewBee @ TAMU for help."
    
  Scenario: Log out
    Given I log out
    Then I should see "Welcome to the TAMURAT"