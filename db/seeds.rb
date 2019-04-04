# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "Example Admin",
             email: "example@railstutorial.org",
             password:              "123456",
             password_confirmation: "123456",
             role: "Administrator",
             login_id: 1000,
             approved: true,
             activated: true,
             activated_at: Time.zone.now
           )
User.create!(name:  "Example DM",
            email: "example@railstutorial.org",
            password:              "123456",
            password_confirmation: "123456",
            role: "Decision Maker",
            login_id: 1001,
            approved: true,
            activated: true,
            activated_at: Time.zone.now
          )
User.create!(name:  "Example VA",
             email: "example@railstutorial.org",
             password:              "123456",
             password_confirmation: "123456",
             role: "Validator",
             login_id: 1002,
             approved: true,
             activated: true,
             activated_at: Time.zone.now
           )
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@treenewbee.com"
  password = "123456"
  role = "Company Representative"
  login_id = n+1003
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               role: role,
               login_id: login_id,
               approved: true,
               activated: true,
               activated_at: Time.zone.now
             )
end


categories =[{:name => 'Business', :weight_sum => 3},
             {:name => 'Security', :weight_sum => 0},
             {:name => 'Finance', :weight_sum => 0},]

categories.each do |category|
  Category.create!(category)
end

#create question
subcategories =[{:name => 'Business_1', :weight_sum => 3, category_id:1, :weight => 1},
             {:name => 'Business_2', :weight_sum => 3, category_id:1, :weight => 1},
             {:name => 'Business_3', :weight_sum => 3, category_id:1, :weight => 1},
             {:name => 'Security_1', :weight_sum => 0, category_id:2, :weight => 0},
             {:name => 'Security_2', :weight_sum => 0, category_id:2, :weight => 0},
             {:name => 'Security_3', :weight_sum => 0, category_id:2, :weight => 0},
             {:name => 'Finance_1', :weight_sum => 0, category_id:3, :weight => 0},
             {:name => 'Finance_2', :weight_sum => 0, category_id:3, :weight => 0},
             {:name => 'Finance_3', :weight_sum => 0, category_id:3, :weight => 0},
             ]

subcategories.each do |subcategory|
  Subcategory.create!(subcategory)
end

questions = [{:name => 'Business_1_q1', :weight => 1, subcategory_id:1},
             {:name => 'Business_1_q2', :weight => 1, subcategory_id:1},
             {:name => 'Business_1_q3', :weight => 1, subcategory_id:1},
             {:name => 'Business_2_q1', :weight => 1, subcategory_id:2},
             {:name => 'Business_2_q2', :weight => 1, subcategory_id:2},
             {:name => 'Business_2_q3', :weight => 1, subcategory_id:2},
             {:name => 'Business_3_q1', :weight => 1, subcategory_id:3},
             {:name => 'Business_3_q2', :weight => 1, subcategory_id:3},
             {:name => 'Business_3_q3', :weight => 1, subcategory_id:3},
             {:name => 'Security_1_q1', :weight => 0, subcategory_id:4},
             {:name => 'Security_1_q2', :weight => 0, subcategory_id:4},
             {:name => 'Security_1_q3', :weight => 0, subcategory_id:4},


             ]

questions.each do |q|
  Question.create!(q)
end


users = User.order(:created_at).take(6)
10.times do
  name = "12345"
  description = Faker::Lorem.sentence(5)
  users.each { |user| user.scenarios.create!(name: name, description: description) }
end
