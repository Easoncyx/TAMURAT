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

## For production environment

In the file `config/environments/production.rb`

change the host address to your server address

```ruby
host = 'https://serene-lowlands-61019.herokuapp.com/'
```

## For local environment

In the file `config/environments/development.rb`

Change the `user_name` and `password` to the email used for sending the notification

Make sure the `host` is your localhost address

The protocal is `http` or `https` in `config.action_mailer.default_url_options = { host: host, protocol: 'http' }`

```ruby
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: 'youremailaddress@gmail.com',
    password: 'yourpassword'
  }
  host = 'http://localhost:3000/'
  config.action_mailer.default_url_options = { host: host, protocol: 'http' }
```

## For Cloud 9 environment

In the file `config/environments/development.rb`

The only change is the `host` and the `protocal`

```ruby
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    authentication: "plain",
    enable_starttls_auto: true,
  
    user_name: 'youremailaddress@gmail.com',
    password: 'yourpassword'
  }
  
  host = 'aee7ba55952c4f12bac4da742212e7ec.vfs.cloud9.us-east-2.amazonaws.com'
  config.action_mailer.default_url_options = { host: host, protocol: 'https' }
```







