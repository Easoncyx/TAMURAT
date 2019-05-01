require 'rails_helper'
RSpec.describe Question, type: :model do
    describe "ActiveRecord test" do
        it { should belong_to(:subcategory)}
        it { should have_many(:answers) } 
    end    

    describe "presence validation" do
        it { is_expected.to validate_presence_of :name }
        it { is_expected.to validate_presence_of :weight }

        it { is_expected.to_not validate_absence_of :name }
        it { is_expected.to_not validate_absence_of :weight }
    end
    
    describe "value validation" do
        it { is_expected.to validate_length_of(:name).is_at_most(512)}
    end
    
    # describe 'Question#import' do
    #     before :each do
    #       @validator = create(:validator)
    #       @CP = create(:representative)
    
    #       @category = create(:category)
    #       @subcategory = create(:sub, category_id: @category.id)
    #       @question = create(:question, subcategory_id: @subcategory.id)
    #       @company = create(:company, user_id: @CP.id )
    #       @answer = create(:answer, company_id: @company.id, question_id: @question.id, validator_id: @validator.id)
          
    #       @file = fixture_file_upload('files/help.csv')
    #     end       
        
    #     it "should have correct subcategory" do
    #         Question.import(@file)
    #         expect(assigns(@question).weight_sum).to eq nil            
    #     end
    # end  
    
    
end