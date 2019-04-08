require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
    
    describe "not login in " do   
        
        before :each do
            session[:user_id] = nil
            #@question = create(:question)
            #question_id = @question.id
        end        
        
        describe "QuestionsController#index" do
            it 'should return to login page' do
                get :index
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
=begin
        
        describe "QuestionsController#show" do
            it 'should return to login page' do
                get :show, params: {:id => question_id}
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
        
=end
    end
        
  
        
    
    before :each do
        @admin = create(:admin)
        session[:user_id] = @admin.id
    end
    
  
    
    
    
end