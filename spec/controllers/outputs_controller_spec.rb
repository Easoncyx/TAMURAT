require 'rails_helper'

RSpec.describe OutputsController, type: :controller do

    describe 'login as admin' do
        before :each do
            @admin = create(:admin)
            session[:user_id] = @admin.id
            
            @category = create(:category)
            @subcategory = create(:sub, category_id: @category.id)
            @question = create(:question, subcategory_id: @subcategory.id)
            @company = create(:company, user_id: @admin.id )
            # @answer = create(:answer, company_id: @company.id, question_id: @question.id, validator_id: @validator.id)
        end    
        
        describe "OutputsController#index" do
            it 'should render the index' do
                get :index
                expect(response).to render_template :index
            end    
        end
        
        describe "OutputsController#show" do
            it 'should redirect_to outputs_path' do
                get :show, params:{id: @company.id }
                expect(response).to redirect_to outputs_path
            end                
        end

        
    end   




end
