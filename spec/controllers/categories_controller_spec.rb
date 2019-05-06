require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
    
    before :each do
        @category = create(:category)
        session[:category_id] = @category.id
    end        
        
    describe "CategoriesController#index" do
        it 'should redirect to questions_url' do
            get :index
            expect(response).to redirect_to questions_url
        end             
    end    

    describe "CategoriesController#show" do
        it 'should redirect to questions_url' do
            get :show, params: { id: session[:category_id] }
            expect(response).to redirect_to questions_url
        end             
    end 
    
    describe "CategoriesController#new" do
        #####
        it "collects category into @category" do
            @category_new = Category.new
            get :new
            expect(assigns(@category.name)).to eq(@category_new.name)
        end        
        
        it 'should render new' do
            get :new
            expect(response).to render_template('new')
        end             
    end        

    describe "CategoriesController#create" do
        it 'should redirect to questions_url and give success message' do
            post :create, params: {:category => attributes_for(:category) }
            
            expect(flash[:success]).to match("#{@category.name} was successfully created.")
            expect(response).to redirect_to questions_url
        end     
        
        it 'should redirect to new_category_path and give danger message' do
            attr = attributes_for(:category)
            attr[:weight] = nil
            post :create, params: {:category => attr }
            
            expect(flash[:danger]).to match("Weight Invalid, you need to type a float.")
            expect(response).to redirect_to new_category_path
        end  
    end  

    describe "CategoriesController#edit" do
        it 'render edit' do
            get :edit, params: { id: session[:category_id] }
            expect(response).to render_template('edit')
        end             
    end      
    
    describe "CategoriesController#update" do
        it 'should redirect to questions_url' do
            put :update, params: { :id => session[:category_id], :category => attributes_for(:category)   }
            ## 
            expect(flash[:success]).to match("#{@category.name} was successfully updated.")
            expect(response).to redirect_to questions_url
        end             
    end    

    describe "CategoriesController#destroy" do
        it 'should redirect to questions_url' do
            delete :destroy,params: { :id => session[:category_id] }
            
            expect(flash[:success]).to match("Category '#{@category.name}' deleted.")
            expect(response).to redirect_to questions_url
        end  
      
    end    
    
   

end