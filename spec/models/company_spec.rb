require 'rails_helper'

RSpec.describe Company, type: :model do
    
    describe "ActiveRecord test" do
       it { should have_many(:answers).with_foreign_key(:company_id).dependent(:destroy) } 
       it { should have_many(:subcategory_scores).with_foreign_key(:company_id).dependent(:destroy) } 
       it { should have_many(:category_scores).with_foreign_key(:company_id).dependent(:destroy) } 
       it { should have_many(:scenario_weights).with_foreign_key('company_id').dependent(:destroy) } 
       it { should have_many(:scenarios)} 
       it { should have_many(:children).with_foreign_key('parent_id').dependent(:destroy) }
       
       it { should belong_to(:user).with_foreign_key(:user_id) } 
       it { should belong_to(:parent).optional } 
    end    

    describe "presence validation" do
        it { is_expected.to validate_presence_of :user_id }
        it { is_expected.to_not validate_absence_of :user_id }
    end

    describe "uniqueness validation" do
        it { is_expected.to validate_uniqueness_of(:user_id) }   
    end
end