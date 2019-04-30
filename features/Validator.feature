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
    Given I am on Companies page
    Then I should see "pickle-morty"
    Then I should see "Example CR1"
    Then I should see "Not answered yet"
    # Given I click "Validate" of "pickle-morty"
    # Then I should see "Questionnaire"
    # Then I should see "Business_1_q1"
    # Then I should see "Not Answered"
    # Then I should see "Not provided."
    Given I log out
    # log in as a CR
    Given I log in as a Company Representative
    Given I am on Questionnaire page
    Then I should see "Questionnaire"
    Then I should see "Business_1_q1"
    Then I should see "Not Answered"
    Then I should see "Answer this question"
    Then I should not see "Edit your answer"
    Then I should not see "Manage evidences"
    # CR answer questions
    Given I click "Answer this question" of "Business_1_q1"
    Then I should see "New Answer"
    Then I should see "Question: Business_1_q1"
    Given I answer and submit
    Then I should see "Successfully Answered question Business_1_q1"
    Then I should see "Not Validated"
    Then I should see "Detail"
    Then I should see "Edit your answer"
    Then I should see "Manage evidences"
    Given I click link "Detail"
    Then I should see "Answer Details"
    Then I should see "level: 3"
    # edit
    Given I am on Questionnaire page
    Then I click link "Edit your answer"
    Given I edit the answer and submit
    Then I should see "Successfully Answered question Business_1_q1"
    Given I click link "Detail"
    Then I should see "level: 4"
    # upload files
    Given I am on Questionnaire page
    Given I click link "Manage evidences"
    Then I should see "All Evidences"
    Given I click link "New evidence"
    Then I should see "New Evidence"
    Given I press "Submit my evidence"
    Then I should see "Please choose evidence file."
    # Given I click link "Manage evidences"
    # Given I click link "New evidence"
    # Given I comment and attach file
    # Given I press "Submit my evidence"
    # Then I should see "Successfully upload evidence"
    Given I log out
    # log in as a validator
    Given I log in as a Validator
    Given I am on Companies page
    Given I click "Validate" of "Example CR1" 
    Then I should see "Validate Example CR1's answers"
    Given I click link "Detail"
    Then I should see "Question: Business_1_q1"
    Then I should see "level: 4"
    Given I am on Companies page
    Given I click "Validate" of "Example CR1" 
    Given I click link "Validate this answer"
    Then I should see "Answer"
    Given I validate this question and submit
    Then I should see "Successfully validate question Business_1_q1"
    Given I click link "Detail"
    Then I should see "level: 5"
    Then I should see "validated: true"
    Then I should see "validator: Example VA1"
    Then I should see "Validate Time:"
    Then I should see "Comment: This is a validation for Business_1_q1."
    # Validated
    Given I am on Companies page
    Given I mark "pickle-morty" as "Validated"
    Then I should see "Successfully validated the company pickle-morty!"
  

  
  
  Scenario: Help page
    Given I am on Help page
    Then I should see "Help"
    Then I should see "Contact the Team TreeNewBee @ TAMU for help."
    
  Scenario: Log out
    Given I log out
    Then I should see "Welcome to the TAMURAT"