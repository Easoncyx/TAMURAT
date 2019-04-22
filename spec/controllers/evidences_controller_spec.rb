require 'rails_helper'

RSpec.describe EvidencesController, type: :controller do

  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end
    
  before :each do
      @category = create(:category)
      @validator = create(:validator)
      session[:user_id] = @validator.id
  end        
      
  describe "EvidencesController#index" do
      it 'should redirect to index page of question' do
          get :index
          expect(response).to redirect_to questions_url
      end             
  end    

  # describe "EvidencesController#show" do
  #     it 'should redirect to index page of question' do
  #         get :show, params: { id: session[:category_id] }
  #         expect(response).to redirect_to questions_url
  #     end             
  # end 
  
  # describe "EvidencesController#new" do
  #     #####
  #     it "collects category into @category" do
  #         @category_new = Category.new
  #         get :new
  #         #expect(assigns(@category.name)).to eq(nil)
  #         expect(assigns(@category.name)).to eq(@category_new.name)
  #     end        
      
  #     it 'should render new' do
  #         get :new
  #         expect(response).to render_template('new')
  #     end             
  # end        

  # describe "EvidencesController#create" do
  #     it 'should redirect to index of question and give flash message' do
  #         post :create, params: {:category => attributes_for(:category) }
          
  #         expect(flash[:success]).to match("#{@category.name} was successfully created.")
  #         expect(response).to redirect_to questions_url
  #     end     
      
  #     it 'should redirect to index of question and give flash message' do
  #         attr = attributes_for(:category)
  #         attr[:weight] = nil
  #         post :create, params: {:category => attr }
          
  #         expect(flash[:danger]).to match("Weight Invalid, you need to type a float.")
  #         expect(response).to redirect_to new_category_path
  #     end  
  # end  

  # describe "EvidencesController#edit" do
  #     it 'render edit' do
  #         get :edit, params: { id: session[:category_id] }
  #         expect(response).to render_template('edit')
  #     end             
  # end      
  
  # describe "EvidencesController#update" do
  #     it 'should redirect to index page of question' do
  #         put :update, params: { :id => session[:category_id], :category => attributes_for(:category)   }
  #         ## 
  #         expect(flash[:success]).to match("#{@category.name} was successfully updated.")
  #         expect(response).to redirect_to questions_url
  #     end             
  # end    

  # describe "EvidencesController#destroy" do
  #     it 'should redirect to index page of question' do
  #         delete :destroy,params: { :id => session[:category_id] }
          
  #         expect(flash[:success]).to match("Category '#{@category.name}' deleted.")
  #         expect(response).to redirect_to questions_url
  #     end  
      
               
  # end    
  
end
