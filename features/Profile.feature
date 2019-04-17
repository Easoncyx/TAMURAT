Feature: Account information
  As a user
  I want to see my porfile
  I can change my name and password

Background:  Log in as a normal user
  Given I log in as pickle-morty
  Then I should see "Welcome to the TAMURAT"
  Then I should see "pickle-morty"
  
  Scenario: Users can see their profile
    Given I am on Home page
    Given I click link "Account"
    Given I click link "Profile"
    Then I should see "pickle-morty"
    Then I should see "1006"
  
  Scenario: Users can edit their account information
    Given I am on Home page
    Given I click link "Account"
    Given I click link "Settings"
    Then I should see "Update your profile"
    # Change name
    Given I edit user name into "Sekiro"
    Then I should see "Profile updated"
    #Given I log in as pickle-morty
    Then I should see "Sekiro"
    # Change password (invalid)
    Given I am on Home page
    Given I click link "Account"
    Given I click link "Settings"
    Given I change password into "12345"
    Given I confirm password with "12345" and submit
    Then I should see "Password is too short (minimum is 6 characters)"
    Given I change password into "123456"
    Given I confirm password with "000000" and submit
    Then I should see "Password confirmation doesn't match Password"
    # Change password
    Given I change password into "000000"
    Given I confirm password with "000000" and submit
    Then I should see "Password has been changed, you need to login again."
    Given I log in with new password
    Then I should see "Welcome to the TAMURAT"
    Then I should see "Sekiro"
    
  Scenario: Log out
    Given I log out
    Then I should see "Welcome to the TAMURAT"
    
    