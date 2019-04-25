require 'rails_helper'

RSpec.describe SubcategoryScore, type: :model do
    describe "ActiveRecord test" do
       it { should belong_to(:subcategory) } 
       it { should belong_to(:company) } 
    end    

end
