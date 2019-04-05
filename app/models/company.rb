class Company < ApplicationRecord
  belongs_to :user, :foreign_key => :user_id, :class_name => "User", dependent: :destroy
  has_many :answers, :foreign_key => :company_id, :class_name => "Answer", dependent: :destroy
  validates :user_id, presence: true, uniqueness: true
end
