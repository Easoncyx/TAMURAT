# TAMURAT Iteration 2 Report

#### Scrum Master: Yixu Chen

#### Product Owner: Feiyan Yu
&nbsp;
[GitHub repo: https://github.com/teamtreenewbee](https://github.com/teamtreenewbee)

[Pivotal Tracker: https://www.pivotaltracker.com/n/projects/2318271](https://www.pivotaltracker.com/n/projects/2319401)

[Heroku: https://vast-retreat-51895.herokuapp.com/](https://vast-retreat-51895.herokuapp.com/)
&nbsp;

#### Team member(alphabetical order):

- Boquan Tao
- Feiyan Yu
- Lijiu Liang
- Shibo Wang
- Yixu Chen
- Zheyong Sun

#### Meeting Time

10:30 am - 12:00 am, Apr 5 2019, HRBB 515

Next meeting： 10：30 am, Apr 12 2019, HRBB 515
&nbsp;
# Our Progress

We expand the scheme of database to support new features. 

- From the legacy code, they write their database directly in schema.rb instead of the migrations feature of Active Record to incrementally modify the database. Therefore we need to refactor the whole database structure
- We add an new admin role who can see the list of all user and delete any one.

To delete a user
![image-201903293](images/image-201903293.png)

Successful deletion
![image-201903294](images/image-201903294.png)


- We write some cucumber test to increase of test coverage from 2% to 30%
- The rspec coverage from 0% to 6%

Cucumber and rspec test
![image-201903291](images/image-201903291.png)

We draw a clear picture to help understand the structure of database. There are still more to add, such as database for problems.
![image-201903295](images/image-201903295.png)
&nbsp;
&nbsp;
## Latest User Stories
### Admin Feature
&nbsp;
#### Feature 14: Admin edit questions(decision maker cannot)
-As an admin
-So that I can provide my desired questions
-I want to edit questions.
---
#### Feature 15: Admin sets certain scenarios for decision maker
-As an admin
-So that I want different decision makers to evaluate differently
-I wan to restrict the scenarios decision makers can see
---
### Validator Feature
&nbsp;
#### Feature 16: Re-validates a company when it changes the answers
-As a validator
-So that I can validates a company more accurately
-I want to re-validate a company
---
&nbsp;
&nbsp;
## Existing User Stories
### Contractor & Subcontractor Feature
&nbsp;
#### Feature 1: Company user could upload pdf
- As a company user
- I want to upload several pdf documents as my company evidence
- So that validator can see or download them
---
#### Feature 2: Company could be evaluated by answering questions
- As an company user
- So that I could be admitted
- I want to fill the questions(csv file) to get evaluated
---
#### Feature 3: Contractors invite subcontractors via email
- As a contractor
- So that I need to add subcontractor
- I want to have a separate page to invite subcontractor via email
---
### Admin Feature
&nbsp;
#### Feature 4: Admin could approve subcontractor invitation and send log in id & default password through email
- As an admin
- So that I could decide whether subcontractor could register or not
- I want to approve subcontractor invitation and send user id and default pw via email
---
### Decision Maker Feature
&nbsp;
#### Feature 5: Decision Maker and Admin could set up scenario
- As an Decision Maker or Admin
- So that I could set up scenario
- I want to give each scenario a name and description
---
#### Feature 6: Decision Maker change companies weight at different scenarios
- As a Decision Maker
- So that I could evaluate companies weight depends on scenarios
- I want to give or change companies weight according to different scenarios
---
#### Feature 7: Decision Maker could change question weights
- As a Decision Maker
- So that I could evaluate each question
- I want to give or change questions weights
---
### Validator Feature
&nbsp;
#### Feature 8: Evaluate company
- As a validator
- So that i could evaluate subcontractors and contractor
- I want to give level(drop down), comments(text box), weight of company(text box), weight of question(text box)
---
#### Feature 9: More than one validators
- As a decision maker or validator
- So that I could see other validation of questions
- I want to see who validates which question
---

### Function Feature
&nbsp;
#### Feature 10: Users could register account
- As a contractor or decision-maker or validator
- So that I could register an account
- I want to fill my email, nickname(company name/validator name), password and role and wait for the log in id sent by admin via email.
---
#### Feature 11: Users could contract admin for support
- As a user
- So that I may meet problems and need help
- I want to have a button to contract admin for support
---
#### Feature 12: Forget and reset password
- As a user or admin
- So that I may forget or want to change password
- I want to reset password via email

#### Feature 13: Notice if password incorrect
- As a user
- So that I want to get notice when password incorrect
- a flash will jump up when password incorrect to note user or admin