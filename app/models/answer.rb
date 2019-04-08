class Answer < ApplicationRecord
  belongs_to :company, class_name: "Company"
  belongs_to :question, class_name: "Question"
  belongs_to :validator, class_name: "User", :foreign_key => :user_id, optional: true
end
