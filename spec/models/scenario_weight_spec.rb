require 'rails_helper'

RSpec.describe ScenarioWeight, type: :model do
    describe "ActiveRecord test" do
       it { should belong_to(:company).with_foreign_key(:company_id) } 
       it { should belong_to(:scenario).with_foreign_key(:scenario_id) }
    end    

    describe "presence validation" do
        it { is_expected.to validate_presence_of :weight }
    end


        
    
    
end
