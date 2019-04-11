require 'rails_helper'

RSpec.describe Subcategory, type: :model do
    
    describe "ActiveRecord validation" do
        
       it { should have_many(:questions) } 
       it { should belong_to(:category) } 
    end    
    
    describe "presence validation" do
        it { is_expected.to validate_presence_of :name }
        it { is_expected.to validate_presence_of :weight_sum }
        it { is_expected.to validate_presence_of :weight }
        
        it { is_expected.to_not validate_absence_of :name }
        it { is_expected.to_not validate_absence_of :weight_sum }
        it { is_expected.to_not validate_absence_of :weight }
    end
    
    describe "value validation" do
        it { is_expected.to validate_length_of(:name).is_at_most(256)}
    end    
end