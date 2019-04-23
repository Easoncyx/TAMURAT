require 'rails_helper'
RSpec.describe Scenario, type: :model do
    
    describe "ActiveRecord test" do
        it { should have_many(:privileges).with_foreign_key('scenario_id').dependent(:destroy)}
        it { should have_many(:users)}
        it { should have_many(:scenario_weights).with_foreign_key('scenario_id').dependent(:destroy)}
    end    

    describe "presence validation" do 
        it { is_expected.to validate_presence_of :name }
        it { is_expected.to validate_presence_of :description }

        it { is_expected.to_not validate_absence_of :name }
        it { is_expected.to_not validate_absence_of :description }
    end
    
    describe "value validation" do
        it { is_expected.to validate_length_of(:name).is_at_most(50)}
        it { is_expected.to validate_length_of(:description).is_at_most(250)}
    end    
end