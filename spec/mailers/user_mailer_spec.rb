require 'rails_helper'

RSpec.describe UserMailer, :type => :mailer do

    before :each do
      @admin = create(:user)
      @admin.activation_token = User.new_token
      @mail = UserMailer.account_activation(@admin)
    end  

    it "renders the headers" do
      expect(@mail.subject).to eq("Account activation")
      expect(@mail.to).to eq([@admin.email])
      expect(@mail.from).to eq(['noreply@example.com'])
      expect(@mail.body.encoded).to match("Hi")
    end

    it "should work after changing pw" do
      @admin.password = "123456"
      @admin.password_confirmation = "123456"
      @admin.reset_token = User.new_token
      @mail = UserMailer.password_reset(@admin)
      
      expect(@mail.subject).to eq("Password reset")
      expect(@mail.to).to eq([@admin.email])
      expect(@mail.from).to eq(['noreply@example.com'])
    end    
    
end