require 'rails_helper'

RSpec.describe ScalesController, type: :controller do
    
    before :each do
        @category = create(:category)
        @scale1 = create(:scale1, category_id: @category.id)
        @scale2 = create(:scale2, category_id: @category.id)
        #@scale2 = create(:scale2)
    end       
    
    describe "not login" do
        describe "ScalesController#index" do
            it 'should redirect to the page of login' do
                get :index
                expect(response).to redirect_to login_url
            end             
        end    
    
        describe "ScalesController#show" do
            it 'should redirect to the page of login' do
                get :show, params: { id: @scale1.id }
                expect(response).to redirect_to login_url
            end             
        end         
    end

    describe " not admin/decision_maker" do
        
        before :each do
            @representative = create(:representative)
            session[:user_id] = @representative.id        
        end        
        
        describe "ScalesController#index" do
            it 'should redirect to the root page' do
                get :index
                expect(response).to redirect_to root_url
            end             
        end    
    
        describe "ScalesController#show" do
            it 'should redirect to the root page' do
                get :show, params: { id: @scale1.id }
                expect(response).to redirect_to root_url
            end             
        end 
    end
   
    describe "login as admin or decision_maker" do
        
        before :each do
            @admin = create(:admin)
            session[:user_id] = @admin.id
        end
        describe "ScalesController#index" do
            it 'should redirect to index page of question' do
                get :index
                expect(response).to render_template("index")
            end             
        end    
    
        describe "ScalesController#show" do
            it 'should redirect to index page of question' do
                get :show, params: { id: @scale1.id }
                expect(response).to render_template("show")
            end             
        end 
         
        describe "ScalesController#update" do
            it 'update successfully and redirect to questions_url' do
                attr = attributes_for(:scale1)
                attr[:category_id] = @category.id
                put :update, params: { :id => @scale1.id, :scale => attr}
                
                expect(flash[:success]).to match("Scale was successfully updated.")
                expect(response).to redirect_to scales_url
            end       
            
            it 'update failed and redirect to edit page' do
                attr = attributes_for(:scale2)
                attr[:category_id] = nil
                put :update, params: { :id => @scale1.id, :scale => attr}
                
                expect(response).to render_template("edit")
            end               
        end  
       
        describe "ScalesController#create" do
            it 'create successfully and redirect to questions_url' do
                attr = attributes_for(:scale1)
                attr[:category_id] = @category.id
                post :create, params: { :id => @scale1.id, :scale => attr}
                
                expect(flash[:info]).to match("Scale was successfully created.")
                expect(response).to redirect_to scales_path
            end          
            
            it 'update failed and redirect to questions_url' do
                attr = attributes_for(:scale2)
                attr[:category_id] = nil
                post :create, params: { :id => @scale2.id, :scale => attr}
                
                expect(response).to render_template("new")
            end               
        end  
        
       
        describe "ScalesController#new" do
            
            it 'should render new' do
                get :new
                expect(response).to render_template('new')
            end             
        end        
    
    
        describe "ScalesController#edit" do
            it 'render edit' do
                get :edit, params: { id: @scale1.id }
                expect(response).to render_template('edit')
            end             
        end      
      
        describe "ScalesController#destroy" do
            
            it 'should redirect to index page of question' do
                delete :destroy,params: { id: @scale1.id }
                
                expect(flash[:success]).to match("Scale deleted")
                expect(response).to redirect_to scales_url
            end          
        end
       
    end

end
