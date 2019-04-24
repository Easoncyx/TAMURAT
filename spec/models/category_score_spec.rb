require 'rails_helper'

RSpec.describe CategoryScore, type: :model do
    describe "ActiveRecord test" do
       it { should belong_to(:category) } 
       it { should belong_to(:company) } 
    end    

   
end
