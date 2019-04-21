require 'rails_helper'

RSpec.describe ScenariosController, type: :controller do

    before :each do
        @admin = create(:admin)
        session[:user_id] = @admin.id
        @scenario = create(:scenario1)
        @admin.create_scenario(@scenario)
    end       

    describe "not login" do
        before :each do
            session[:user_id] = nil
        end
        
        describe "ScenariosController#index" do
            it 'should redirect to the page of login' do
                get :index
                expect(response).to redirect_to login_url
            end             
        end    
    
        describe "ScenariosController#show" do
            it 'should redirect to the page of login' do
                get :show, params: { id: @scenario.id }
                expect(response).to redirect_to login_url
            end             
        end         
        
    end

    describe " not admin/decision_maker" do
        
        before :each do
            @representative = create(:representative)
            session[:user_id] = @representative.id        
        end        
        
        describe "ScenariosController#index" do
            it 'should redirect to the root page' do
                get :index
                expect(response).to redirect_to root_url
            end             
        end    
    
        describe "ScenariosController#show" do
            it 'should redirect to the root page' do
                get :show, params: { id: @scenario.id }
                expect(response).to redirect_to root_url
            end             
        end 
    end
  
    describe "login as admin" do
        
        before :each do
            #@admin = create(:admin)
            session[:user_id] = @admin.id
        end
        
        describe "ScenariosController#index" do
            
            it 'should redirect to index page of question' do
                get :index
                expect(response).to render_template('index')
            end    
            
            it 'should collect all the scenarios' do
                get :index
                expect(assigns(@scenarios)["scenarios"]).to eq(Scenario.all)
            end            
        end    
  
        describe "ScenariosController#show" do
            it 'should render show' do
                get :show, params: { id: @scenario.id }
                expect(response).to render_template("show")
            end             
        end 
         
        describe "ScenariosController#update" do
            
            it 'update successfully and redirect to scenario_url' do
                attr = attributes_for(:scenario1)
                attr[:user_id] = @admin.id
                put :update, params: { :id => @scenario.id, :scenario => attr}
                
                expect(flash[:success]).to match("#{@scenario.name} was successfully updated.")
                expect(response).to redirect_to scenario_url
            end       
            
        end  
          
        describe "ScenariosController#create" do
            it 'create successfully and redirect to scenarios_url' do
                attr = attributes_for(:scenario1)
                attr[:user_id] = @admin.id
                post :create, params: { :id => @scenario.id, :scenario => attr}
                
                expect(flash[:success]).to match("Scenario created!")
                expect(response).to redirect_to scenarios_url
            end          
            
            it 'update failed and redirect to new_question_url' do
                attr = attributes_for(:scenario1)
                attr[:user_id] = @admin.id
                attr[:description] = nil
                post :create, params: { :id => @scenario.id, :scenario => attr}
                
                expect(flash[:warning]).to match("Scenario create failed!")
                expect(response).to redirect_to scenarios_url
            end               
        end  
        
       
        describe "ScenariosController#new" do
            it 'should render new' do
                get :new
                expect(response).to render_template('new')
            end             
        end        
   
        describe "ScenariosController#edit" do
            it 'render edit' do
                get :edit, params: { id: @scenario.id }
                expect(response).to render_template('edit')
            end             
        end      
     
        describe "ScenariosController#destroy" do
            
            it 'should redirect to index page of question' do
                delete :destroy,params: { id: @scenario.id }
                
                expect(flash[:success]).to match("Scenario deleted")
                expect(response).to redirect_to scenarios_url
            end          
           
        end     
       
    end

    describe "login as decision_maker" do
        
        before :each do
            @DM = create(:DM)
            session[:user_id] = @DM.id
        end
        
        describe "ScenariosController#show" do
            it 'not the right user and return to scenarios_url' do
                get :show,params: { id: @scenario.id }
                expect(flash[:danger]).to match("Do not meddle with other's scenarios!")
                expect(response).to redirect_to scenarios_url
            end            
        end        
        
        describe "ScenariosController#create" do
            it 'create failed and redirect to scenarios_url' do
                attr = attributes_for(:scenario3)
                post :create, params: {:scenario => attr}
                
                expect(flash[:warning]).to match("Scenario create failed!")
                expect(response).to redirect_to scenarios_url
            end          
        end  
        
      
    end
end