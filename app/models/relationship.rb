class Relationship < ApplicationRecord
    belongs_to :answer, class_name: "Answer"
    belongs_to :evidence, class_name: "Evidence"
    validates :answer_id, presence: true
    validates :evidence_id, presence: true
end
