# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
categories =[{:name => 'Business', :weight_sum => 0},
             {:name => 'Security', :weight_sum => 0},
             {:name => 'Finance', :weight_sum => 0},]
        
categories.each do |category|
  Category.create!(category)
end


subcategories =[{:name => 'Business_1', :weight_sum => 0, category_id:1, :weight => 0},
             {:name => 'Business_2', :weight_sum => 0, category_id:1, :weight => 0},
             {:name => 'Business_3', :weight_sum => 0, category_id:1, :weight => 0},
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

questions = [{:name => 'Business_1_q1', :weight => 0, subcategory_id:1},
             {:name => 'Business_1_q2', :weight => 0, subcategory_id:1},
             {:name => 'Business_1_q3', :weight => 0, subcategory_id:1},
             {:name => 'Business_2_q1', :weight => 0, subcategory_id:2},
             {:name => 'Business_2_q2', :weight => 0, subcategory_id:2},
             {:name => 'Business_2_q3', :weight => 0, subcategory_id:2},
             {:name => 'Business_3_q1', :weight => 0, subcategory_id:3},
             {:name => 'Business_3_q2', :weight => 0, subcategory_id:3},
             {:name => 'Business_3_q3', :weight => 0, subcategory_id:3},
             {:name => 'Security_1_q1', :weight => 0, subcategory_id:4},
             {:name => 'Security_1_q2', :weight => 0, subcategory_id:4},
             {:name => 'Security_1_q3', :weight => 0, subcategory_id:4},
             
             
             ]

questions.each do |q|
  Question.create!(q)
end