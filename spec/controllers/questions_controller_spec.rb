require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

    
    before :each do
        @category = create(:category)
        @subcategory = create(:sub, category_id: @category.id )
        @question = create(:question, subcategory_id: @subcategory.id)
    end       

    describe "not login" do
        before :each do
            session[:user_id] = nil
        end
        
        describe "QuestionsController#index" do
            it 'should redirect to the page of login' do
                get :index
                expect(response).to redirect_to login_url
            end             
        end    
    
        describe "QuestionsController#show" do
            it 'should redirect to the page of login' do
                get :show, params: { id: @question.id }
                expect(response).to redirect_to login_url
            end             
        end         
        
        describe "QuestionsController#update" do
            it 'should redirect to the page of login' do
                put :update, params: { :id => @question.id, :subcategory => attributes_for(:question)   }
                expect(response).to redirect_to login_url
            end             
        end          
    end

    describe " not admin/decision_maker" do
        
        before :each do
            @representative = create(:representative)
            session[:user_id] = @representative.id        
        end        
        
        describe "QuestionsController#index" do
            it 'should redirect to the root page' do
                get :index
                expect(response).to redirect_to root_url
            end             
        end    
    
        describe "QuestionsController#show" do
            it 'should redirect to the root page' do
                get :show, params: { id: @subcategory.id }
                expect(response).to redirect_to root_url
            end             
        end 
    end
   
    describe "login as admin or decision_maker" do
        
        before :each do
            @admin = create(:admin)
            session[:user_id] = @admin.id
        end
        
        describe "QuestionsController#index" do
            
            it 'should redirect to index page of question' do
                get :index
                expect(response).to render_template('index')
            end       
           
            it 'find all the questions in each category and subcategory' do
                get :index
                a = assigns(@result)
                expect(a["result"][@category][@subcategory].to_a[0]).to eq(@question) 
            end                
        end    
  
        describe "QuestionsController#show" do
            it 'should redirect to index page of question' do
                get :show, params: { id: @question.id }
                expect(response).to redirect_to questions_url
            end             
        end 
         
        describe "QuestionsController#update" do
            
            it 'update successfully and redirect to questions_url' do
                attr = attributes_for(:question)
                attr[:subcategory_id] = @subcategory.id
                put :update, params: { :id => @question.id, :question => attr   }
                
                expect(flash[:success]).to match("#{@question.name} was successfully updated.")
                expect(response).to redirect_to questions_url
            end       
            
            it 'update failed and redirect to edit page' do
                attr = attributes_for(:question)
                attr[:subcategory_id] = @subcategory.id
                attr[:weight] = 'a'
                put :update, params: { :id => @question.id, :question => attr   }
                
                expect(flash[:danger]).to match("Weight Invalid, you need to type a float.")
                expect(response).to redirect_to edit_question_url(@question.id) 
            end               
        end  
         
        describe "QuestionsController#create" do
            it 'create successfully and redirect to questions_url' do
                attr = attributes_for(:question)
                attr[:subcategory_id] = @subcategory.id
                post :create, params: {:question => attr }
                
                expect(flash[:success]).to match("#{@question.name} was successfully created.")
                expect(response).to redirect_to questions_url
            end          
            
            it 'update failed and redirect to new_question_url' do
                attr = attributes_for(:question)
                attr[:subcategory_id] = @subcategory.id
                attr[:weight] = 'a'
                post :create, params: {:question => attr }
                
                expect(flash[:danger]).to match("Weight Invalid, you need to type a float.")
                expect(response).to redirect_to new_question_url
            end               
        end  
        
       
        describe "QuestionsController#new" do
            it 'should render new' do
                get :new
                expect(response).to render_template('new')
            end             
        end        
   
        describe "QuestionsController#edit" do
            it 'render edit' do
                get :edit, params: { id: @question.id }
                expect(response).to render_template('edit')
            end             
        end      
       
        describe "QuestionsController#destroy" do
            
            it 'should redirect to index page of question' do
                delete :destroy,params: { id: @question.id }
                
                expect(flash[:success]).to match("Question '#{@question.name}' deleted.")
                expect(response).to redirect_to questions_url
            end          
           
        end     
       
    end

end


