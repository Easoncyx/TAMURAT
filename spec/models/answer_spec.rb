require 'rails_helper'
RSpec.describe Answer, type: :model do
    
    describe "ActiveRecord test" do
        it { should belong_to(:company)}
        it { should belong_to(:question)}
        it { should belong_to(:validator).optional}
        it { should have_many(:relationships)}
        it { should have_many(:evidences)}
    end    

end