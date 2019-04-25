require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    
    before :each do
        @admin = create(:admin)
    end        
        
    describe "SessionsController#new" do
        it 'render signup_url' do
            get :new
            expect(response).to render_template :new
        end             
    end    
    
    describe "SessionsController#create" do
        it 'login failed and render new ' do
            post :create, params: {:session => {:login_id => 10001, :password => '1a1a1a'}}
            expect(response).to render_template :new
        end         
        
        it 'login successfully and redirect_to root ' do
            post :create, params: {:session => {:login_id => 1000, :password => '111111'}}
            expect(response).to redirect_to root_url
        end          
        
    end 

    describe "SessionsController#new" do
        it 'destroy and reture to root' do
            delete :destroy
            expect(response).to redirect_to root_url
        end             
    end    
        

end