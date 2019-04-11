class Company < ApplicationRecord
  belongs_to :user, :foreign_key => :user_id, :class_name => "User", dependent: :destroy
  has_many :answers, :foreign_key => :company_id, :class_name => "Answer", dependent: :destroy
  
  #connect itself
  has_many :children, class_name: "Company", foreign_key: "parent_id", :dependent => :destroy
  belongs_to :parent, class_name: "Company", optional: true



  validates :user_id, presence: true, uniqueness: true
end
