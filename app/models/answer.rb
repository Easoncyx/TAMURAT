class Answer < ApplicationRecord
  belongs_to :company, class_name: "Company"
  belongs_to :question, class_name: "Question"
  belongs_to :validator, class_name: "User", :foreign_key => :validator_id, optional: true
  has_many :relationships, class_name: "Relationship", foreign_key: "answer_id", dependent: :destroy
  has_many :evidences, -> { select 'evidences.*, relationships.comment as comment' }, through: :relationships
  
  def create_evidence(ed)
    evidences << ed
  end
  
  def delete_evidence(ed)
    evidences.delete(ed)
  end
  
  def has_evidence?(ed)
    evidences.include?(ed)
  end

end
