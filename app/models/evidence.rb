class Evidence < ApplicationRecord
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "evidence_id", dependent: :destroy
  has_many :answers, through: :passive_relationships
  has_one_attached :file
  
  
    
end
