class Company < ApplicationRecord
  belongs_to :user
  has_many :answers, :foreign_key => :company_id, 
    :class_name => "Answer", :dependent => destroy
  validates :user_id, presence: true, uniqueness: true
end
