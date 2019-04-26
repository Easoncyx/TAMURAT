require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
    
    describe 'login as Validator' do
        before :each do
            @validator = create(:validator)
            session[:user_id] = @validator.id
            
            @category = create(:category)
            @subcategory = create(:sub, category_id: @category.id)
            @question = create(:question, subcategory_id: @subcategory.id)
            @company = create(:company, user_id: @validator.id )
            @answer = create(:answer, company_id: @company.id, question_id: @question.id, validator_id: @validator.id)
        end    
        
        describe "AnswersController#index" do
            it 'should render the index page' do
                get :index
                expect(response).to render_template :index
            end    
        end
        
        describe "AnswersController#show" do
            it 'should render the show page' do
                get :show, params:{id: @answer.id, question_id: @question.id  }
                expect(response).to render_template :show
            end                
        end
        
        describe "AnswersController#edit" do
            it 'should render the edit page' do
                get :edit, params:{id: @answer.id, question_id: @question.id  }
                # expect(flash[:warning]).to match("Your answer has validated.")
                expect(response).to render_template :edit
            end         
            
            it 'validator could edit comment or level after company has been validated' do
                @cp = create(:representative)
                @company1 = create(:company1,user_id: @cp.id)
                @answer = create(:answer, company_id: @company1.id, question_id: @question.id, validator_id: @validator.id)
                
                get :edit, params:{id: @answer.id, question_id: @question.id  }
                expect(response).to render_template :edit
            end   
        end
        
        describe "AnswersController#update" do
            it 'update successfully and redirect_to answers_path' do
                answer_attr = attributes_for(:answer)
                answer_attr[:company_id] = @company.id
                answer_attr[:question_id] = @question.id
                answer_attr[:validator_id] = @validator.id

                patch :update, params: { id: @answer.id, :answer =>answer_attr}
                expect(response).to redirect_to answers_path(:company_id => @company.id )
            end           
        end

        describe "AnswersController#new" do
            it 'should redirect_to root_path because Authentication' do
                get :new
                expect(response).to redirect_to root_path
            end             
        end    
        
    end   
        
    describe 'login as Company Representative' do
        before :each do
            @validator = create(:validator)
            @representative = create(:representative)
            session[:user_id] = @representative.id
            
            @category = create(:category)
            @subcategory = create(:sub, category_id: @category.id)
            @question = create(:question, subcategory_id: @subcategory.id)

        end    
        
        describe "AnswersController#index" do
            it 'should render index' do
                @company = create(:company, user_id: @representative.id )
                @answer = create(:answer, company_id: @company.id, question_id: @question.id, validator_id: @validator.id)
                get :index
                expect(response).to render_template('index')
            end    
        end

        describe "AnswersController#new" do
            it 'not validated and redirect_to edit_answer_path' do
                @company = create(:company, user_id: @representative.id )
                @answer = create(:answer, company_id: @company.id, question_id: @question.id, validator_id: @validator.id)
                get :new, params: { question_id: @question.id, company_id:  @company.id }
                expect(response).to redirect_to edit_answer_path(@answer.id)
            end   
            
            it 'validated and redirect_to answers_path' do
                @company = create(:company, user_id: @representative.id ,validated: true)
                @answer = create(:answer, company_id: @company.id, question_id: @question.id, validator_id: @validator.id)
                
                get :new, params: { question_id: @question.id, company_id:  @company.id }
                expect(response).to redirect_to answers_path
            end     
            
            it 'not validated and no answer' do
                @company = create(:company, user_id: @representative.id ,validated: true)
                # @answer = create(:answer, company_id: @company.id, question_id: @question.id, validator_id: @validator.id)
                
                get :new, params: { question_id: @question.id, company_id:  @company.id }
                expect(response).to redirect_to answers_path
            end   
        end     
        
    end
    
end