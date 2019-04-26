require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
    
    before :each do
        @admin = create(:admin)
        # session[:user_id] = @admin.id
    end        
    
    describe "PasswordResetsController#new" do
        it 'should render new' do
            get :new
            expect(response).to render_template(:new)
        end
    end
    
    describe "PasswordResetsController#new" do
        it 'should check login_id and send email' do
            post :create, params:{:password_reset => {:login_id =>@admin.login_id }}
            expect(open_last_email).to be_delivered_from 'noreply@example.com'
            expect(open_last_email).to be_delivered_to @admin.email
            expect(open_last_email).to have_subject "Password reset"          

            expect(response).to redirect_to root_url
        end
        it 'should give note and render new if login_id is invalid' do
            post :create, params:{:password_reset => {:login_id =>@admin.login_id+1 }}
         
            expect(flash[:danger]).to match("Login_id not found")
            expect(response).to render_template(:new)
        end
    end    
    
    # describe "AccountActivationsController#edit" do
    #     it 'should check login_id and activated then render edit' do
    #         @user = create(:representative)
    #         @user.activated = true
    #         @user.create_reset_digest
    #         activation_token = @user.reset_token
    #         @user.save
    #         get :edit, params:{:id =>activation_token,:login_id => @user.login_id}
    #         expect(response).to render_template(:edit)
    #     end    
        
    #     it 'should check login_id and activated then redirect_to root_url if invalid' do
    #         @user = create(:representative)
    #         @user.create_reset_digest
    #         activation_token = @user.reset_token
    #         @user.save
    #         get :edit, params:{:id =>activation_token,:login_id => @user.login_id}
    #         expect(response).to redirect_to root_path
    #     end 
        
    #     it 'should check reset time then redirect_to root_url if expired' do
    #         @user = create(:representative)
    #         @user.create_reset_digest
    #         @user.activated = true
    #         activation_token = @user.reset_token
    #         @user.update_attribute(:reset_sent_at, 2.hours.ago)
    #         @user.save
    #         get :edit, params:{:id =>activation_token,:login_id => @user.login_id}
    #         expect(flash[:danger]).to match("Password reset has expired.")
    #         expect(response).to redirect_to new_password_reset_url
    #     end 
    # end        
    describe "AccountActivationsController#update" do
        it 'should update the password and redirect_to @user' do
            @user = create(:representative)            
            @user.activated = true
            @user.create_reset_digest
            activation_token = @user.reset_token
            @user.save
            patch :update, params:{:login_id =>@user.login_id ,:id =>activation_token, :user =>{:password  => '123456', :password_confirmation => '123456'}}
            expect(response).to redirect_to @user
        end    
        
        it 'should check the password and render edit if empty' do
            @user = create(:representative)            
            @user.activated = true
            @user.create_reset_digest
            activation_token = @user.reset_token
            @user.save
            patch :update, params:{:login_id =>@user.login_id ,:id =>activation_token, :user =>{:password  => '', :password_confirmation => ''}}
            expect(response).to render_template :edit
        end   
        
        it 'password should meet the format' do
            @user = create(:representative)            
            @user.activated = true
            @user.create_reset_digest
            activation_token = @user.reset_token
            @user.save
            patch :update, params:{:login_id =>@user.login_id ,:id =>activation_token, :user =>{:password  => '1', :password_confirmation => '1'}}
            expect(response).to render_template :edit
        end  
        
        it 'password should be equal to password_confirmation' do
            @user = create(:representative)            
            @user.activated = true
            @user.create_reset_digest
            activation_token = @user.reset_token
            @user.save
            patch :update, params:{:login_id =>@user.login_id ,:id =>activation_token, :user =>{:password  => '1', :password_confirmation => '12'}}
            expect(response).to render_template :edit
        end 
    end    
end