require 'rails_helper'

RSpec.describe Category, type: :model do
    
    describe "ActiveRecord validation" do
       it { should have_many(:subcategories) } 
       it { should have_many(:scales) } 
    end    
    
    describe "presence validation" do
        it { is_expected.to validate_presence_of :name }
        it { is_expected.to validate_presence_of :weight_sum }
        
        it { is_expected.to_not validate_absence_of :name }
        it { is_expected.to_not validate_absence_of :weight_sum }
    end
    
    describe "value validation" do
        it { is_expected.to validate_length_of(:name).is_at_most(256)}
    end    
end