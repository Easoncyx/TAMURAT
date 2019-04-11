Feature: Admin Powers
  
  As an admin
  I want to see a list of users
  So that I can manage them
  
Background:  Log in as an Admin
  Given I log in as an Admin
  Then I should see "Welcome to the TAMURAT"
  
  Scenario: See all users list
    Given I am on All user page
    Then I should see "All users"
    Then I should see "pickle-rick"
    Then I should see "pickle-morty"

  Scenario: Delete the first user
    Given I am on All user page
    When I delete the first user
    Then I should see "User deleted"
    Then I should not see "Example DM"
  
  # Scenario: Activate a user
  #   Given I am on All user page
  #   When I activate user "pickle-rick"
  #   Then I should see "Account activated!"
  #   Given I log in as "pickle-rick"
  #   Then I should see "Welcome to the TAMURAT"
  
  
  
  
 
