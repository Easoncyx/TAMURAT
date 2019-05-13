require 'csv'
require 'zip'
class Answer < ApplicationRecord
  belongs_to :company, class_name: "Company"
  belongs_to :question, class_name: "Question"
  belongs_to :validator, class_name: "User", :foreign_key => :validator_id, optional: true
  has_many :relationships, class_name: "Relationship", foreign_key: "answer_id", dependent: :destroy
  has_many :evidences, -> { select 'evidences.*, relationships.comment as comment' }, through: :relationships

  # validate the questions.csv in the zip file
  def self.csv_check?(file)
    files = []
    Zip::File.open(file) do |zipfile|
      zipfile.each do |file|
        files.push file
      end
    end
    csvfile = files.select{|f| f.name == "questions.csv"}
    if !csvfile
      # byebug
      # flash[:warning] = "csv file does not exist in zipfile."
      return false
    end
    content = csvfile[0].get_input_stream.read

    CSV.parse(content, headers: true) do |row|
      id, category, subcategory, name, level, evidences = row
      if level[1] && id[1] # level and id not empty
        if !(id[1].to_s =~ /\A\d+\z/ && Question.exists?(id[1].to_i))
          # byebug
          # flash[:warning] = "Question does not exist in the system."
          return false
        end
        if !(level[1].to_s && Scale.check_answer?(id[1].to_i, level[1].to_s))
          # byebug
          # flash[:warning] = "Level in your answer does not exist in the system."
          return false
        end
        if evidences[1] # evidences not empty
          evidences_file_names = evidences[1].split(';')
          evidences_file_names.each do |filename|
            csvfile = nil
            csvfile = files.select{|f| f.name == filename.strip}
            if csvfile.empty?
              # byebug
              # flash[:warning] = "No evidence file found."
              return false
            end
          end
        end
      # else # if level and id are empty
      #   flash[:warning] = "Either Level or ID is empty."
      #   return false
      end
    end
    return true
  end

  def self.import(file, company_id)
    files = []
    Zip::File.open(file) do |zipfile|
      zipfile.each do |file|
        files.push file
      end
    end


    csvfile = files.select{|f| f.name == "questions.csv"}
    content = csvfile[0].get_input_stream.read

    CSV.parse(content, headers: true) do |row|
      newanswer = {}
      id, category, subcategory, name, level, evidence = row
      if level[1] # level not empty
        newanswer['company_id'] = company_id
        newanswer['question_id'] = id[1].to_i
        newanswer['validated'] = false
        newanswer['level'] = level[1].to_s
        answer = Answer.create!(newanswer)

        if evidence[1] # evidence not empty
          evidence_file_names = evidence[1].split(';')
          evidence_file_names.each do |filename|
            csvfile = files.select{|f| f.name == filename}
            if csvfile
              @evidence = Evidence.new()
              @evidence.file.attach(io: StringIO.new(csvfile[0].get_input_stream.read), filename: csvfile[0].name)
              @evidence.save

              Relationship.create(answer: answer, evidence: @evidence)
            else
              # flash[:warning] = "No evidence file found."
              redirect_to import_users_path and return
            end
          end
        end
      end

    end


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
