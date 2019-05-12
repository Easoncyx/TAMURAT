require 'csv'
require 'zip'
class Answer < ApplicationRecord
  belongs_to :company, class_name: "Company"
  belongs_to :question, class_name: "Question"
  belongs_to :validator, class_name: "User", :foreign_key => :validator_id, optional: true
  has_many :relationships, class_name: "Relationship", foreign_key: "answer_id", dependent: :destroy
  has_many :evidences, -> { select 'evidences.*, relationships.comment as comment' }, through: :relationships


  def self.import(file)
    Zip::File.open(file) do |zipfile|
      zipfile.each do |file|
        # do something with file
      end
    end
    # CSV.foreach(file, headers: true) do |row|
    #   category, subcategory, name, weight = row
    #
    # end

  end

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
