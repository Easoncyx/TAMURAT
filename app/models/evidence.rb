class Evidence < ApplicationRecord
  has_many :relationships, class_name: "Relationship", foreign_key: "evidence_id", dependent: :destroy
  has_many :answers, through: :relationships
  has_one_attached :file
end
