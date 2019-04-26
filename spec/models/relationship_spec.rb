require 'rails_helper'

RSpec.describe Relationship, type: :model do
    describe "ActiveRecord test" do
       it { should belong_to(:evidence) } 
       it { should belong_to(:answer) } 
    end    

    describe "presence validation" do
        
        it { is_expected.to validate_presence_of :answer_id }
        it { is_expected.to validate_presence_of :evidence_id }
    end

end
