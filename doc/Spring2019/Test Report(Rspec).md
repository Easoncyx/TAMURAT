## Test with Rspec
### Overview
In this project, we use Rsepc for TDD. Since there are many functions are implemented in the project, such as create account, upload file, send email and activate account via email, we use many other helpful packages to improve the quality of testing. Here are all the package we used:
* rspec-rails : bone of TDD
* simplecov : show the overall coverage of testing
* byebug : debugging tool
* fixture : mocking uploaded file
* factory_bot_rails : mocking variables for testing
* faker: generating email and personal name for convenience
* shoulda_matchers : simplifing the Model test
* email_sepc : email testing

Up to now, the overall coverage is about 77%, only few files are not covered yet and the following rspec test will be done soon. We use rspec here here mainly for unit test and cucumber for integration test.

### Model Test
In model test, we focus on the relationships between each model and the definition of each model variables. `shoulda_matchers` is widely used here because it has many simplified matchers. 
The relationships between each model generally contains `belongs_to`, `foreign_key` and `dependent`. And definition of each model variables includes `validates`,`presence`,`length`,`format` and etc. There are many private functions definied in each model but we do not test them directly but merged into controller test.
we cover all the Model implemented in the project:
* scenario : The whole task has different work assignments to access
* scenario_weight : the importance of each scenario
* category : questions have different classes and we classify them into categories
* scale : the criterian of answers for each category
* category_score : the quality of overall questions answered by one company in category 
* subcategory : category may be too vague and subcategories could help validators and companies 
* subcategory_score: the quality of overall questions answered by one company in subcategoriy
* question : questions for validation
* answer : answers of each question in each subcategory
* evidence : file of answer
* user : user account with different roles
* company : the main object of this project
* privilege : the mid-model between user(admin) and scenario
### Controller Test
Controller test is the main work in rspec. Most controller have `before_action` to check the permission of current_user so we have to deploy the test for the same action but under different current_user such as Admin, Validator, Decision Maker and Company Representative.
Generally, we use `expect(response)` to test the workflow of each action to make sure they render or redirect to the correct views. For some actions like create and update, we use `expect(assigns)` to check the details like variables and parameters. Factory_Bot is very important here to mock different valid or invalid variables so that the test could go on. 
### Helper and Mailer
Implement in Mailer is simple but important, email_sepc is used to test the sender, recipient, subject or context of email and etc. The functions in Helper are not test directly but they are called frequently in the test of controller and them are covered in the end.
### Challenge
We use the latest version of Rspec and take a period of time to get used to it. The test of activation via email cost us a lot of time because we did not found the documents in the Internet. We have to know the mechanism of rpsec and controllers very well so that we could solve the problem.
