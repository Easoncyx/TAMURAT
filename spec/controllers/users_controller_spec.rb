require 'rails_helper'


RSpec.describe UsersController, type: :controller do
    
    describe "login as admin" do
    
        before :each do
            @admin = create(:admin)
            session[:user_id] = @admin.id

        end
        
        describe "UsersController#index" do
            it 'should render the home in views/users' do
                get :index
                expect(response).to render_template :index
            end             
        end


        describe "UsersController#show" do
            
            it 'should render the show in views/users' do
                get :show, params: { id: session[:user_id] }
                expect(response).to render_template :show
            end           
            
        end
        
        
        describe "UsersController#new" do
            
            it 'should render the new in views/users' do
                get :new
                expect(response).to render_template('new')
                
            end             
        
        end
    
        describe "UsersController#new" do
        
            it 'should render the home in views/users' do
                get :new
                expect(response).to render_template('new')
            end             
        
        end    
        
        describe "UsersController#create" do
        
            it "redirects to contacts#show" do
        
                post :create, params: {:user => attributes_for(:admin) } 
                expect(response).to redirect_to user_url(2)
                
            end

            
#           it 'should render the home in views/new if information saved unsuccessfully' do
#                @failed_admin = create(:failed_admin)            
#                session[:failed_admin] = @failed_admin.id
#                post :create, params: {:user => attributes_for(:failed_admin) } 
#                expect(response).to render_template('new')
#           end      
        end    
        
        describe "UsersController#edit" do
        
            it 'should render the home in views/users' do
                get :edit, params: { id: session[:user_id] }
                expect(response).to render_template('edit')
            end             
        
        end        
        
        
        describe "UsersController#update" do
            it 'should render the home in views/new if information updated successfully' do
#                put :update, params: { id: @admin.id }
                patch :update, params: { :id => session[:user_id] }
#                put :update, params: {:user => attributes_for(:admin) } 
                
                expect(response).to redirect_to user_url(session[:user_id])
            end             
        
#           it 'should render the home in views/new if information updated unsuccessfully' do
#               patch :update
#               expect(response).to render_template('edit')
#           end                  
        
        end        
        
        
    end
end
  


=begin    

    

    

    

    describe "UsersController#destroy" do
        it 'should render the home in views/users' do
            delete :destroy, user: attributes_for(:user)
            expect(response).to redirect_to user_url(@user)
        end               
        
    end
=end
   
   
   
    
