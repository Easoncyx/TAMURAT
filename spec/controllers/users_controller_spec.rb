require 'rails_helper'

RSpec.describe UsersController, type: :controller do
#########################################################not login##############################################       
    describe "UsersController#index" do
        it 'should render the home in views/users' do
            get :index
            expect(response).to redirect_to login_url
        end             
    end
    
    describe "UsersController#create" do
        it "login_id show assigned correctly" do
            @admin = create(:admin)
            session[:user_id] = @admin.id
            post :create, params: {:user => attributes_for(:admin) }
            expect(@admin.login_id).to eq 1000
        end           
            
        it "redirects to contacts#show" do
            post :create, params: {:user => attributes_for(:admin_for_create) }
            expect(response).to redirect_to root_url
        end
           
        it 'should render new if information saved unsuccessfully with password' do
            post :create, params: {:user => attributes_for(:failed2) } 
            expect(response).to render_template('new')
        end              
    end        
    
#########################################################login as admin##############################################    
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
            it 'should render the home in views/users' do
                get :new
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
            it 'should render show if information updated successfully' do
                patch :update, params: { :id => session[:user_id], :user => attributes_for(:admin)   }
                expect(response).to redirect_to user_url(session[:user_id])
            end             

           it 'should render edit if information updated unsuccessfully with password' do
               patch :update,params: { :id => session[:user_id], :user => attributes_for(:failed2)   }
               expect(response).to render_template('edit')
           end
        end        
        
        
        describe "UsersController#destroy" do
            it 'should render the home in views/users' do
                delete :destroy, params: { :id => session[:user_id] }
                expect(response).to redirect_to users_url
            end               
        end    
    end
    
#########################################################login as Company Representative##############################################
    
    describe "login as Company Representative" do
        
        before :each do
            @representative = create(:representative)
            session[:user_id] = @representative.id
        end        
        
        describe "UsersController#index" do
            it 'should render the home in views/users' do
                get :index
                expect(response).to redirect_to root_url
            end             
        end

        describe "UsersController#show" do
            it 'should render the show in views/users' do
                get :show, params: { id: session[:user_id] }
                expect(response).to render_template :show
            end           
        end
    
        describe "UsersController#new" do
            it 'should render the home in views/users' do
                get :new
                expect(response).to redirect_to root_url
            end             
        end    
       
        describe "UsersController#edit" do
            it 'should render the home in views/users' do
                get :edit, params: { id: session[:user_id] }
                expect(response).to render_template('edit')
            end             
        end        
       
        describe "UsersController#update" do
            it 'should render show if information updated successfully' do
                patch :update, params: { :id => session[:user_id], :user => attributes_for(:representative)   }
                expect(response).to redirect_to user_url(session[:user_id])
            end             
        
           it 'should render edit if information updated unsuccessfully with name' do
               patch :update,params: { :id => session[:user_id], :user => attributes_for(:failed3)   }
               expect(response).to render_template('edit')
           end                  

           it 'should render edit if information updated unsuccessfully with password' do
               patch :update,params: { :id => session[:user_id], :user => attributes_for(:failed4)   }
               expect(response).to render_template('edit')
           end
        end        
          
        
        describe "UsersController#destroy" do
            it 'should render the home in views/users' do
                delete :destroy, params: { :id => session[:user_id] }
                expect(response).to redirect_to root_url
            end               
        end            
      
    end
end
  



    
