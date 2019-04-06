require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
    
    describe "not login in " do   
        
        describe "QuestionsController#index" do
            it 'should return to login page' do
                get :index
                expect(response).to redirect_to login_url
            end             
        end    

        describe "QuestionsController#show" do
            it 'should return to login page' do
                get :show
                expect(response).to redirect_to login_url
            end             
        end    
        describe "QuestionsController#create" do
            it 'should return to login page' do
                post :create
                expect(response).to redirect_to login_url
            end             
        end    
        describe "QuestionsController#new" do
            it 'should return to login page' do
                get :new
                expect(response).to redirect_to login_url
            end             
        end    
        describe "QuestionsController#edit" do
            it 'should return to login page' do
                get :edit
                expect(response).to redirect_to login_url
            end             
        end    
        describe "QuestionsController#update" do
            it 'should return to login page' do
                put :update
                expect(response).to redirect_to login_url
            end             
        end    
        describe "QuestionsController#destroy" do
            it 'should return to login page' do
                delete :destroy
                expect(response).to redirect_to login_url
            end             
        end         
    end
        
    
    
    before :each do
        @admin = create(:admin)
        session[:user_id] = @admin.id
    end
    
    
    
    
    
end