# How to create the first Administrator?

1. Install the app successfully.

2. In the file `/db/seeds.rb`, change the field of `name`, `email` and `password` to what you want. And make the `password_confirmation` the same as `passowrd` field. Don't change other fields.

  ```ruby
  User.create!(name:  "Example Admin",
               email: "example@railstutorial.org",
               password:              "123456",
               password_confirmation: "123456",
               role: "Administrator",
               login_id: 1000,
               activated: true,
               activated_at: Time.zone.now
             )
  ```

3. Then use the following command to create the first Administrator User in the app:

  ```
  rails db:seed
  ```



# How to setup the email to send out notification?

In the file `config/environments/production.rb`



# How to add new user to the system?

