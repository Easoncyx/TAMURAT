# How to add new user to the system?

New user need to sign up and input their information and wait for the approval of administrator before they can log in to the system.

User need to specify the following field:

- Name, used for identify the person who will take action in the system
- Email, used for reset password
- Role, can be "Decision Maker", "Validator" or "Company Representative"
- Password

After approved by the admin, the user will receive an email. The login_id will be given in the email. Click the link in the email to activate the account. You need to use login_id to log in to the system due to one email can have multiple account. **Please remember your login_id.**





# What can a Administrator do in this system?

As an admin, you can:

- In the `Account-> Profile` tab. You can edit your profile.
- In the `Invite` tab. You can invite another administrator to the system.
- In the `Users` tab. You can manage all the users in the system.
  - Delete existing user
  - Activate the pending application
- In the `Questions` tab. You can manage all the questions, subcategories and categories
  - Import question through csv
  - Create new question, category and subcategory
  - Delete question, category or subcategory
  - Edit question, including the name and weight and which subcategory they belongs to
  - Edit subcategory and category
- In the `Scales` tab. You can manage scales which are the answers for a certain type of questions
  - Each scale belongs to a category 
  - The level are the text of answer the company user can see when answering questions
  - The score are the credit they get when choosing this answer, used for calculating the final score
- In the `Scenarios` tab. You can manage the visibility of  scenarios
  - Assign or delete the authority of a Decision Maker to view a certain scenario
  - Edit and delete scenarios created by Admin or Decision Maker
  - Change the weight of each company in a certain scenario
  - See the final score of each scenario
- In the `Outputs` tab. You can see the output of all Company
  - Check the score of:
    - each company
    - each category
    - each subcategory
    - each question
  - Check the subcompany structure



# What can I do as a company representative?

- In the `Account-> Profile` tab. You can edit your profile and see all your sub-companies.
- In the `Questionnairs` tab. You can answer questions, provide evidence and see the scales of questions.
- In the `Invite` tab. You can invite sub-companies. Sub-companies are those that provide service for you.

# What can I do as a validator?

- In the `Account-> Profile` tab. You can edit your profile.
- In the `Companies` tab. 
  - You can see all the companies that have answered questions.
  - You can validate each company and change their level if you think their answer is inaccurate.
  - You can view their evidences for each answer.
  - You can see other validator's comment if a company has already been validated.
  - You can finalize the validation so that the company cannot change their answers anymore by select the drop down in`validated` column to `true` and then click `validated`.

# What can I do as a decision maker?

- You can edit your profile.
- In the `Questions` tab. You can see all the questions, subcategories and categories
- In the `Outputs` tab. You can see the output of the Companies that have been validated
  - Check the score of:
    - each company
    - each category
    - each subcategory
    - each question
  - Check the subcompany structure
- In the `Scenarios` tab. You can:
  - Create scenarios 
  - Edit your scenarios assigned by the admin, change the weight of each company in a certain scenario
  - You can see the score of each scenario and finally make a decision.



# How to upload eveidence?

Company representative can upload evidence files to the website. Validator can see the evidence and evaluate wisely based on it. It is possible that one file corresponds to many questions. In this case, the file is only stored once in the system.
- After answering one question, the company representative can manage his/her evidences to this question. He/she can upload, delete, edit and destroy evidence.
- Sometimes one evidence may be very big and the company representative can write comment about this evidence regarding to which specific paragraph is relevant.


# How to import questions through CSV file?
Creating questions one by one can be tiresome. We add a function to upload CSV file of questions and those questions will be stored in the database.
- The CSV file will include header.
- The CSV file has four columns: category, subcategory, question, weight. These four attributes are necessary to identify and define a question.

