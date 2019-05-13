require 'rails_helper'
RSpec.describe Scale, type: :model do
    
    describe "ActiveRecord test" do
        it { should belong_to(:category)}
    end    
    describe "presence validation" do
        
        it { is_expected.to validate_presence_of :name }
        it { is_expected.to validate_presence_of :category_id }
        it { is_expected.to validate_presence_of :level }
        it { is_expected.to validate_presence_of :score }
     
        it { is_expected.to_not validate_absence_of :name }
        it { is_expected.to_not validate_absence_of :category_id }
        it { is_expected.to_not validate_absence_of :level }
        it { is_expected.to_not validate_absence_of :score }
    end
end