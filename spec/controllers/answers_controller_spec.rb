require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
    
    describe 'login as Validator' do
        before :each do

            @validator = create(:validator)
            @company = create(:company, user_id: @validator.id )
            session[:user_id] = @validator.id
        end    
        
        describe "AnswersController#index" do
            it 'should render the home in views/users' do
                get :index
                expect(response).to render_template :index
            end             
        end

    # describe "AnswersController#show" do
    #     it 'should render the show in views/users' do
    #         get :show, params: { id: session[:user_id] }
    #         expect(response).to render_template :show
    #     end           
    # end

    # describe "AnswersController#new" do
    #     it 'should render the home in views/users' do
    #         get :new
    #         expect(response).to render_template('new')
    #     end             
    # end    
    
    # describe "AnswersController#edit" do
    #     it 'should render the home in views/users' do
    #         get :edit, params: { id: session[:user_id] }
    #         expect(response).to render_template('edit')
    #     end             
    # end            
        
    end
    
end