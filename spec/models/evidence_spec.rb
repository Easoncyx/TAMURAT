require 'rails_helper'

RSpec.describe Evidence, type: :model do
    describe "ActiveRecord test" do

        it { should have_many(:relationships)}
        it { should have_many(:answers)}
    end    
  
end
