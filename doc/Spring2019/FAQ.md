# What's the logic behind this app?

We have 4 roles in this app:

- Administrator 
- Decision Maker
- Validator
- Company Representative

This app is for a large company to evaluate their contractor and sub-contractor. After the contractor's answering the questions and upload evidence. The validators log in and validate all the answers and evidence and finalize their decision so that the contractor can't change their answers and evidences.

Validated by the validator, a score will be calculated following the formulae of weighted sum for each subcategory and category of questions.

The Admin and the Decision Maker can both create scenarios to weight company on different scale. The Admin decide which Decision Maker can see and edit which scenario. 

Then the Decision Maker can see the output of each company and the score of each scenario to select the best solution for their project.

The administrator is in charge of setting up everything in this app, including users, questions, scenarios, and scales. Only the administrator can invite other administrators.

The Company Representative can also invite their sub-company, after approved by the Admin, they will receive their activation email and login_id.

# How to add a new user to the system?

New user needs to sign up and input their information and wait for the approval of an administrator before they can log in to the system.

User needs to specify the following field:

- Name, used to identify the person who will take action in the system
- Email, used for reset password
- Role, can be "Decision Maker", "Validator" or "Company Representative"
- Password

After approved by the admin, the user will receive an email. The login_id will be given in the email. Click the link in the email to activate the account. You need to use login_id to log in to the system due to one email can have multiple accounts. **Please remember your login_id.**





# What can an Administrator do in this system?

As an admin, you can:

- In the `Account-> Profile` tab. You can edit your profile.
- In the `Invite` tab. You can invite another administrator to the system.
- In the `Users` tab. You can manage all the users in the system.
  - Delete existing user
  - Activate the pending application
- In the `Questions` tab. You can manage all the questions, subcategories and categories
  - Import questions through a CSV file
  - Create new questions, categories, and subcategories
  - Delete questions, categories or subcategories
  - Edit questions, including the name and weight and which subcategory they belong to
  - Edit subcategories and categories
- In the `Scales` tab. You can manage scales which are the answers for a certain type of questions
  - Each scale belongs to a category 
  - The level is the text of answer that the company user can choose from when answering questions
  - The score is the credit they get when choosing this answer, used for calculating the final score
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
- In the `Questionnaires` tab. You can answer questions, provide evidence and see the scales of questions.
- In the `Invite` tab. You can invite sub-companies. Sub-companies are those that provide service for you.

# What can I do as a validator?

- In the `Account-> Profile` tab. You can edit your profile.
- In the `Companies` tab. 
  - You can see all the companies that have answered questions.
  - You can validate each company and change their level if you think their answer is inaccurate.
  - You can view their evidence for each answer.
  - You can see other validator's comment if a company has already been validated.
  - You can finalize the validation by selecting the drop-down in the `validated` column to `true` and then click `validated` so that the company cannot change their answers anymore.

# What can I do as a decision maker?

- You can edit your profile.
- In the `Questions` tab. You can see all the questions, subcategories, and categories
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



# How to upload evidence?

A company representative can upload evidence files to the website. A validator can see the evidence and evaluate wisely based on it. It is possible that one file corresponds to many questions. In this case, the file is only stored once in the system.
- After answering one question, the company representative can manage his/her evidence to this question. He/she can upload, delete, edit and destroy evidence.
- Sometimes one evidence may be very big and the company representative can write a comment about this evidence regarding which specific paragraph is relevant.


# How to import questions through CSV file?
Creating questions one by one can be tiresome. We add a function to upload CSV file of questions and those questions will be stored in the database.
- The CSV file will include a header.
- The CSV file has four columns: category, subcategory, question, weight. These four attributes are necessary to identify and define a question.

This is an example csv:

| **category**  | **subcategory** | **name**       | **weight** |
| ------------- | --------------- | -------------- | ---------- |
| **Bussiness** | Bussiness_1     | Bussiness_1_q1 | 1          |
| **Bussiness** | Bussiness_1     | Bussiness_1_q2 | 1          |
| **Bussiness** | Bussiness_2     | Bussiness_2_q1 | 1          |
| **Bussiness** | Bussiness_2     | Bussiness_2_q2 | 1          |
| **Security**  | Security_1      | Security_1_q1  | 1          |
| **Security**  | Security_1      | Security_1_q2  | 1          |
| **Security**  | Security_2      | Security_2_q1  | 1          |
| **Security**  | Security_2      | Security_2_q2  | 1          |


# How to calculate the final score of a company in a certain scenario?

In the `Help` tab, you can see the formulae of calculating the final score and the weight of each category and subcategory.

