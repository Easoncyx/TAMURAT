RSpec.describe Question, type: :model do
    describe "ActiveRecord test" do
        it { should belong_to(:subcategory)}
        it { should have_many(:answers) } 
    end    

    describe "presence validation" do
        it { is_expected.to validate_presence_of :name }
        it { is_expected.to validate_presence_of :weight }

        it { is_expected.to_not validate_absence_of :name }
        it { is_expected.to_not validate_absence_of :weight }
    end
    
    describe "value validation" do
        it { is_expected.to validate_length_of(:name).is_at_most(512)}
    end    
end