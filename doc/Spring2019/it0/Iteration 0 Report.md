# TAMURAT Iteration 0 Report

#### Scrum Master: Yixu Chen

#### Product Owner: Feiyan Yu
[GitHub repo: https://github.com/teamtreenewbee](https://github.com/teamtreenewbee)

[Pivotal Tracker: https://www.pivotaltracker.com/n/projects/2318271](https://www.pivotaltracker.com/n/projects/2319401)

Vimeo link (Client Interview): https://vimeo.com/325282104

#### Team member(alphabetical order):
- Boquan Tao
- Feiyan Yu
- Lijiu Liang
- Shibo Wang
- Yixu Chen
- Zheyong Sun

#### Meeting Time
11:00 am - 12:00 am, Mar 8 2019, HRBB 515

9:00 am - 4:00 pm, Mar 11 2019, Evans 6th

## Customer Requirments
There is a rigid demand for government agencies to determine whether or not a network service is appropriate to be outsourced from a certain company. Each company should answer a series of questions and provide their evidence of each question for validators to evaluate. And based on these evaluations, decision makers choose a company with best performance. In addition, the system also needs one or more administrators which are responsible for managing the privilege of other accounts. The main customer need is to add a new kind of user, administrator, into this existing system and this new role will be responsible for managing all accounts in the system.

## Stakeholders
Company, validator, decision maker, administrator

## Overall strategy for learning/improving the prior code
This is a legacy project, we will form 3 small teams of 2 people to do pair programming for each user story.

For this term, we want to add some new features and finish some previous features. For example, the legacy code already have csv input feature, but it havn't realized storing the files in cloud and display it to the validator. Besides the csv file for answering questions we will add a feature allowing user to upload multiple pdf files as evidences to allow validator to evaluate the level (such as reliable, suffienct, unkown, insuffient) for each questions.

We will also furnish some detail of the previous app such as the flash message if the password is wrong when log in. Add forget password feature.

A new administer account will be used to manage the role for other accounts. Every account registered in the system have to be approved by the admin.

Validators and decision makers will be able to see the level evaluated by other validator and who evaluate which question.

## User Stories
### Feature1: admin changes roles of other accounts
As an admin

So that I should manage the privilege of other accounts

I want to change the roles of registered users

### Feature2: user creates an account
As a user

So that I want to use the function of system

I want to create an account to be approved by an admin

### Feature3: forget and reset password
As a user or admin

So that I may forget or want to change password

I want to reset password via email

### Feature4: notice if password incorrect
As a user or admin

So that I want to get noticed when password incorrect

### Feature5: company user could upload pdf
As a company user

I want to upload several pdf documents as my company evidence

So that validator can see or download them

### Feature6: evaluate evidence by validator
As a validator

I want to evaluate evidence from companies

So that I can give different levels to each question

### Feature7: More than one validators
As a validator or decision maker

I want to see who validates which question

### Feature8: Import and Export Excel
As a company user

I want to download template(excel) to fill questions and upload it with evidence as a zip
