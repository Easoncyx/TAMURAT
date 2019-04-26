require 'rails_helper'

RSpec.describe AccountActivationsController, type: :controller do
    
    before :each do
        @admin = create(:admin)
        session[:user_id] = @admin.id
    end        
    
    describe "AccountActivationsController#edit" do
        it 'has no right and redirect_to login_path' do
            @user = create(:representative)            
            @user.create_activation_digest
            activation_token = @user.activation_token
            @user.create_company
            @user.save
            # UserMailer.account_activation(@user).deliver_now

            
            get :edit, params:{:id =>activation_token,:login_id => @user.login_id}
            
            expect(response).to redirect_to user_url(@user.id)
        end    
    end        
   
end