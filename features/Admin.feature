Feature: Admin Features
  
  As an admin
  I want to see a list of users
  So that I can manage them
  I want to see a list of all questions
  So that I can manage them or create new category
  I want to see scales 
  So that I can manage them or create new scale
  I want to see a list of all scenarios
  So that I can manage them or create new scenario
  
Background:  Log in as an Admin
  Given I log in as an Admin
  Then I should see "Welcome to the TAMURAT"
  
  Scenario: Admin can see all users list
    Given I am on All user page
    Then I should see "All users"
    Then I should see "pickle-rick"
    Then I should see "pickle-morty"

  Scenario: Admin can delete user
    Given I am on All user page
    When I delete the first user
    Then I should see "User deleted"
    Then I should not see "Example DM1"
    
  Scenario: Activate a user
    Given I am on All user page
    When I activate a user
    Then I should see "Successfully send email"
  
  Scenario: Admin can management all questions
    Given I am on All question page
    Then I should see "All Question"
    #question
    Given I edit the first category into "pickle-rick"
    Then I should see "pickle-rick was successfully updated."
    Given I create a new category "pickle-morty"
    Then I should see "pickle-morty was successfully created."
    #sub-question
    Given I click link "pickle-rick"
    Then I should see "Business_1"
    Given I edit subcategory "Business_1" into "pickle-rick_1"
    Then I should see "pickle-rick_1 was successfully updated."
    Then I should see "Weight_sum = 9.7"
    Given I click link "pickle-rick Weight = 0.0"
    Then I should see "pickle-rick_1"
    Given I create a new subcategory "pickle-rick_4"
    Then I should see "pickle-rick_4 was successfully created."
    Given I click link "pickle-rick Weight = 0.0"
    Then I should see "pickle-rick_4"
    #sub-sub-question
    Given I click link "pickle-rick_1"
    Then I should see "Business_1_q1"
    Given I edit question "Business_1_q1" into "pickle-rick_1_q1"
    Then I should see "pickle-rick_1_q1 was successfully updated."
    Given I click link "pickle-rick Weight = 0.0"
    Given I click link "pickle-rick_1 Weight = 7.7"
    Then I should see "pickle-rick_1_q1"
    Given I create a new question "pickle-rick_1_q4"
    Then I should see "pickle-rick_1_q4 was successfully created."
    Given I click link "pickle-rick Weight = 0.0"
    Given I click link "pickle-rick_1 Weight = 7.7"
    Then I should see "pickle-rick_1_q4"
    Given I input invalid in "Weight"
    Then I should see "Weight Invalid, you need to type a float."
    #Given I delete the question "pickle-rick"
  
  Scenario: Admin can manage scales
    Given I am on Scales page
    Then I should see "Scales"
  
  Scenario: Admin can manage scenarios
    Given I am on All Scenarios page
    Then I should see "All Scenarios"
    
  Scenario: Log out
    Given I log out
    Then I should see "Welcome to the TAMURAT"
  
    
    
    
    
  
  
 
