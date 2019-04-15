require 'rails_helper'
RSpec.describe Scale, type: :model do
    
    describe "ActiveRecord test" do
        it { should belong_to(:category)}
    end    


end