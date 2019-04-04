require 'rails_helper'

RSpec.describe User, type: :model do

    describe "presence validation" do
        
        it { is_expected.to validate_presence_of :name }
        it { is_expected.to validate_presence_of :password }
        it { is_expected.to validate_presence_of :email }
        it { is_expected.to validate_presence_of :login_id }
        it { is_expected.to validate_presence_of :role }
     
        it { is_expected.to_not validate_absence_of :name }
        it { is_expected.to_not validate_absence_of :password }
        it { is_expected.to_not validate_absence_of :email }
        it { is_expected.to_not validate_absence_of :login_id }
        it { is_expected.to_not validate_absence_of :role }
        
        it { is_expected.to have_secure_password  }
    end

    describe "uniqueness validation" do
        subject {FactoryBot.build(:user)}
        it { is_expected.to validate_uniqueness_of(:login_id) }   
    end
    
    describe "value validation" do
        it "pw could be nil when changing pw" do
            user = FactoryBot.build(:pw_changer)
            expect(user.password).to eq nil
        end

        it { is_expected.to validate_length_of(:name).is_at_most(50)}
        it { is_expected.to validate_length_of(:email).is_at_most(255)}
        it { is_expected.to validate_length_of(:password).is_at_least(6)}
    end
 
    describe "method test" do
        it "should work well on admin?" do
            user = FactoryBot.build(:user)
            expect(user.admin?).to eq true
        end
    end
    
end