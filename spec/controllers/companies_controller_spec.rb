require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
    
    describe "login as admin" do
    
        before :each do
            @admin = create(:admin)
            session[:user_id] = @admin.id
            @company = create(:company, user_id:  @admin.id)
        end    
        
        describe "CompaniesController#update" do
            it 'should render the show in views/users' do
                patch :update, params: { id: @company.id }
                expect(response).to redirect_to root_url
            end           
        end

    end

    describe "login as validator" do
    
        before :each do
            @validator = create(:validator)
            session[:user_id] = @validator.id
            @company = create(:company, user_id:  @validator.id)
        end    
        
        describe "CompaniesController#update" do
            it 'should render the show in views/users' do
                patch :update, params: { id: @company.id }
                # expect(flash[:danger]).to match("Please log in as correct user.")
                expect(response).to redirect_to companies_path
            end           
        end

        describe "CompaniesController#index" do
            it 'should render the show in views/users' do
                get :index
                expect(response).to render_template('index')
            end           
        end
        
    end
    
end
