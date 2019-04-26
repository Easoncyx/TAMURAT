require 'rails_helper'
require 'fixture'

RSpec.describe EvidencesController, type: :controller do

  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end
    
  describe 'not login' do
    it 'should redirect to index page of question' do
        get :index
        expect(response).to redirect_to login_url
    end   
  end
  
  describe 'login as admin' do
    before :each do
      @admin = create(:admin)
      session[:user_id] = @admin.id
    end    
    describe "EvidencesController#index" do
      it 'should redirect to index page of question' do
          get :index
          expect(flash[:warning]).to match("You do not permission.")
          expect(response).to redirect_to root_url
      end   
    end
  end    
    
  describe 'login as validator' do
    before :each do
      @validator = create(:validator)
      @CP = create(:representative)
      session[:user_id] = @validator.id
      
      @category = create(:category)
      @subcategory = create(:sub, category_id: @category.id)
      @question = create(:question, subcategory_id: @subcategory.id)
      @company = create(:company, user_id: @CP.id )
      @answer = create(:answer, company_id: @company.id, question_id: @question.id, validator_id: @validator.id)
    end    

    describe "EvidencesController#index" do
      it 'should render the index' do
          get :index, params:{answer_id: @answer.id}
          # expect(flash[:warning]).to match("You do not permission.")
          expect(response).to render_template :index
      end  
      
      it 'should redirect to answers_url is answer id is invalid' do
          get :index, params:{answer_id: @answer.id+1}
          expect(flash[:warning]).to match("Please choose a valid answer.")
          expect(response).to redirect_to answers_url
      end   
      
      it 'should get the @answer according to the id' do
          get :index, params:{answer_id: @answer.id}
          expect(assigns("answer")).to eq @answer
      end    
    end
    
    describe "EvidencesController#create" do
      it 'permission denied' do
          post :create
          expect(flash[:warning]).to match("You do not have permission.")
          expect(response).to redirect_to root_url
      end     
    end      
  end
  
  describe 'login as company representative' do
    before :each do
      @validator = create(:validator)
      @CP = create(:representative)
      session[:user_id] = @CP.id
      # byebug
      @category = create(:category)
      @subcategory = create(:sub, category_id: @category.id)
      @question = create(:question, subcategory_id: @subcategory.id)
      @company = create(:company, user_id: @CP.id )
      @answer = create(:answer, company_id: @company.id, question_id: @question.id, validator_id: @validator.id)
      
      @file = fixture_file_upload('files/help.csv')
      @evidence = create(:evidence, file: @file)
      # @relationship = create(:relationship, answer_id: @answer.id, evidence_id: @evidence.id, comment: '2333')
    end    

    describe "EvidencesController#index" do
      it 'should render the index' do
          get :index, params:{answer_id: @answer.id}
          # expect(flash[:warning]).to match("You do not permission.")
          expect(response).to render_template :index
      end  
      
      it 'should redirect to answers_url is answer does not belong to the CP    ' do
          get :index, params:{answer_id: @answer.id+1}
          expect(flash[:warning]).to match("You do not have permission to edit other's evidence!")
          expect(response).to redirect_to answers_url
      end   
      
      it 'should get the @answer according to the id' do
          get :index, params:{answer_id: @answer.id}
          expect(assigns("answer")).to eq @answer
      end    
    end
    
    describe "EvidencesController#create" do
      it 'should have file or redirect_to evidences_url' do
          evi_attr = attributes_for(:evidence)
          evi_attr[:file] = @file
          evi_attr[:answer_id] = @answer.id
          
          rl_attr = attributes_for(:relationship)
          rl_attr[:answer_id] = @answer.id
          rl_attr[:evidence_id] = @evidence.id
          rl_attr[:comment] = '2333'
      
          post :create, params:{:evidence =>evi_attr , :relationship => rl_attr }
          expect(flash[:success]).to match("Successfully upload evidence")
          expect(response).to redirect_to evidences_url(answer_id: @answer.id)
      end     
      
      it 'without file and redirect_to answers_url' do
          evi_attr = attributes_for(:evidence)
          # evi_attr[:file] = nil
          evi_attr[:answer_id] = @answer.id
          
          rl_attr = attributes_for(:relationship)
          rl_attr[:answer_id] = @answer.id
          rl_attr[:evidence_id] = @evidence.id
          rl_attr[:comment] = '2333'
      
          post :create, params:{:evidence =>evi_attr , :relationship => rl_attr }
          expect(flash[:warning]).to match("Please choose evidence file.")
          expect(response).to redirect_to answers_url
      end 
    end
    

    describe "EvidencesController#new" do
        it 'should redirect_to answers_url' do
            get :new
            expect(response).to redirect_to answers_url
        end             
    end      
    
    describe "EvidencesController#edit" do
        it 'should redirect_to answers_url ' do
            get :edit, params: { id: @evidence.id, answer_id: @answer.id}
            expect(response).to render_template(:edit)
        end             
    end 
    
    describe "EvidencesController#update" do
      
        it 'update successfully will redirect_to evidences_url' do
          
            evi_attr = attributes_for(:evidence)
            evi_attr[:file] = @file
            evi_attr[:answer_id] = @answer.id          
            
            rl_attr = attributes_for(:relationship)
            rl_attr[:answer_id] = @answer.id
            rl_attr[:evidence_id] = @evidence.id
            rl_attr[:comment] = '23333'          
            
            put :update, params:{id: @evidence.id,:relationship => rl_attr,:evidence =>evi_attr}
            
            expect(flash[:success]).to match("Successfully updated.")
            expect(response).to redirect_to evidences_url(answer_id: @answer.id)
          
        end      
        
        it 'update successfully with empty file will redirect_to evidences_url' do
          
            evi_attr = attributes_for(:evidence)
            evi_attr[:answer_id] = @answer.id          
            
            rl_attr = attributes_for(:relationship)
            rl_attr[:answer_id] = @answer.id
            rl_attr[:evidence_id] = @evidence.id
            rl_attr[:comment] = '23333'          
            
            put :update, params:{id: @evidence.id,:relationship => rl_attr,:evidence =>evi_attr}
            
            expect(flash[:success]).to match("Successfully updated.")
            expect(response).to redirect_to evidences_url(answer_id: @answer.id)
        end   
    end         
    
    describe "EvidencesController#destroy" do
      it 'should redirect to index page of question' do
        delete :destroy,params: { id: @evidence.id, answer_id: @answer.id}
          
        expect(flash[:success]).to match("Evidence deleted")
        expect(response).to redirect_to evidences_url(answer_id: @answer.id)
      end    
    end
      
    

    
  end          
    
   
    
  
end  
