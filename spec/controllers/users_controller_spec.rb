require 'rails_helper'


RSpec.describe UsersController, type: :controller do
    render_views
    
    before :each do
      @user = build(:user)
      session[:user_id] = @user.id
    end
    
    describe "UsersController#index" do
        it 'should render the home in views/users' do
            get :index
            expect(response).to render_template :index
        end             
        
    end

=begin
    describe "UsersController#show" do
        
        it 'should render the home in views/users' do
            get :show
            expect(response).to render_template('show')
        end             
        
    end
    
    describe "UsersController#new" do
        
        it 'should render the home in views/users' do
            get :new
            expect(response).to render_template('new')
        end             
        
    end
    
    describe "UsersController#create" do
        
        it 'should render the home in views/new if information saved successfully' do
            post :create, user: attributes_for(:user)
            expect(response).to redirect_to ('new')
        end             
        
#        it 'should render the home in views/new if information saved unsuccessfully' do
#            post :create, user: attributes_for(:user)
#            expect(response).to render_template('new')
#        end             
    end
    
    describe "UsersController#edit" do
        
        it 'should render the home in views/users' do
            get :edit, user: attributes_for(:user)
            expect(response).to render_template('edit')
        end             
        
    end
    
    describe "UsersController#update" do
        it 'should render the home in views/new if information updated successfully' do
            patch :update, user: attributes_for(:user)
            expect(response).to redirect_to ('new')
        end             
        
#        it 'should render the home in views/new if information updated unsuccessfully' do
#            patch :update
#            expect(response).to render_template('edit')
#        end                  
        
    end
    describe "UsersController#destroy" do
        it 'should render the home in views/users' do
            delete :destroy, user: attributes_for(:user)
            expect(response).to redirect_to user_url(@user)
        end               
        
    end

=end
   
   
   
    
end