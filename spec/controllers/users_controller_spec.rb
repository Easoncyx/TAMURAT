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
            
            it "login_id show assigned correctly" do
                
                post :create, params: {:user => attributes_for(:admin) }
                expect(@admin.login_id).to eq 1000
            end           
            
            it "redirects to contacts#show" do
                
                post :create, params: {:user => attributes_for(:admin_for_create) }
                expect(response).to redirect_to user_url(2)
            end

           it 'should render the home in views/new if information saved unsuccessfully' do
                post :create, params: {:user => attributes_for(:failed) } 
                expect(response).to render_template('new')
           end      
           
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
                patch :update, params: { :id => session[:user_id], :user => attributes_for(:admin)   }
#                put :update, params: {:user => attributes_for(:admin) } 
                
                expect(response).to redirect_to user_url(session[:user_id])
            end             
        
           it 'should render the home in views/new if information updated unsuccessfully' do
               patch :update,params: { :id => session[:user_id], :user => attributes_for(:failed)   }
               expect(response).to redirect_to user_url(session[:user_id])
               #expect(response).to render_template('edit')
           end                  
        
        end        
        
        
        describe "UsersController#destroy" do
            
            it 'should render the home in views/users' do
                
                delete :destroy, params: { :id => session[:user_id] }
                expect(response).to redirect_to users_url
                
        end               
        
    end    
        
        
        
    end
end
  


=begin    

    

    

    


=end
   
   
   
    
