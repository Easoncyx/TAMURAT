Feature: Admin Powers
  
  As an admin
  I want to see all three kinds of users
  So that I can manage them
  
# Background: Admin is logged in
#   Given I am on the signin page
#   And I follow "Sign in with Google"
#   Then I am on the home page
Background:  Sign up as an Admin
  Given I am signing up as an Admin
  
  
  
  
  Scenario: Home page shown
    Given I am on Home page
    When I follow "Home"
    Then I should see "Home tab"
  
  Scenario: Manage all users
    Given I am on Users management page
    Then I should see "All Users" 
   
  
  Scenario: Create a new Scenario
    Given I am on Home page
    When I follow "Scenario"
    And I follow "Add new Course of Action"
    And I fill in "name" with "123"
    And I fill in "description" with "321"
    And I press "Save Changes"
    Then I should see "123"
    And I should see "321"
  
  
  
  
 
