require 'rails_helper'

RSpec.describe ActivateController, type: :controller do
    
    describe 'not login' do
        describe "AnswersController#activate" do
            it 'has no right and redirect_to login_path' do
                get :activate
                expect(response).to redirect_to login_path
            end    
        end        
    end    
    
    describe 'login as decision maker' do
        before :each do
            @DM = create(:DM)
            session[:user_id] = @DM.id
        end      
        describe "AnswersController#activate" do
            it 'has no right and redirect_to root_path' do
                get :activate
                expect(response).to redirect_to root_path
            end    
        end        
    end
    
    describe 'login as Company Representative' do
        before :each do
            @representative = create(:representative)
            session[:user_id] = @representative.id
        end    
        describe "AnswersController#index" do
            it 'has no right and redirect_to root_path' do
                get :activate
                expect(response).to redirect_to root_path
            end    
        end
    end        
        
    describe 'login as admin' do
        before :each do
            @admin = create(:admin)
            session[:user_id] = @admin.id
            
            
            
        end    
        describe "AnswersController#index" do
            it 'send email successfully and return to users_url' do
                @user = create(:representative)
                get :activate,params:{:login_id => @user.login_id}
                
                expect(open_last_email).to be_delivered_from 'noreply@example.com'
                expect(open_last_email).to be_delivered_to @user.email
                expect(open_last_email).to have_subject "Account activation"

                expect(flash[:success]).to match("Successfully send email")
                expect(response).to redirect_to users_url
            end    
        end
        
        describe "AnswersController#index" do
            it 'already activated and return to users_url, no email sent' do
                @user = create(:representative, activated: true)
                get :activate,params:{:login_id => @user.login_id}

                expect(flash[:warning]).to match("User Already Activated!")
                expect(response).to redirect_to users_url
            end    
        end
    end   
        
end