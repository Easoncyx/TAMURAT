require 'rails_helper'

RSpec.describe Privilege, type: :model do

    describe "ActiveRecord test" do
        it { should belong_to(:user)}
        it { should belong_to(:scenario)}

    end      
    describe "presence validation" do
        
        it { is_expected.to validate_presence_of :user_id }
        it { is_expected.to validate_presence_of :scenario_id }
    end  
  
  
  
end
