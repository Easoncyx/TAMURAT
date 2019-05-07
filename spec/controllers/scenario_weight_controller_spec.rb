require 'rails_helper'

RSpec.describe ScenarioWeightController, type: :controller do

  describe "not login" do
      before :each do
          session[:user_id] = nil
      end
      
      describe "ScenarioWeightController#submit" do
          it 'no login and should redirect to the page of login' do
              post :submit
              expect(response).to redirect_to login_url
          end             
      end    
  end

  describe " not admin/decision_maker" do
      before :each do
          @representative = create(:representative)
          session[:user_id] = @representative.id        
      end        
      
      describe "ScenarioWeightController#submit" do
          it 'has no right and should redirect to the root page' do
              post :submit
              expect(response).to redirect_to root_url
          end             
      end    
  
  end
  
  describe "login as admin" do
      
      before :each do
          @admin = create(:admin)
          session[:user_id] = @admin.id
          
          @CP = create(:representative)
          @company = create(:company, user_id: @CP.id )
          @scenario = create(:scenario1)
          @scenario_weight1 = create(:scenario_weight1, company_id: @company.id, scenario_id: @scenario.id)
          # @scenario_weight2 = create(:scenario_weight2, company_id: @company.id, scenario_id: @scenario.id)
      end
      
      describe "ScenarioWeightController#submit" do
        it "update weight successfully and redirect_to scenarios_path" do
          # byebug
          get :submit, params:{:scenario_id => @scenario.id ,:sw => {@scenario_weight1.id =>{"weight"=>"343"}}}
          expect(response).to redirect_to scenarios_path
        end
        
        it "weight contain invalid symbol and redirect_to edit_scenario_path(@scenario.id)" do
          # byebug
          get :submit, params:{:scenario_id => @scenario.id ,:sw => {@scenario_weight1.id =>{"weight"=>"3a"}}}
          expect(flash[:danger]).to match("Weight Invalid, you need to type a float.")
          expect(response).to redirect_to edit_scenario_path(@scenario.id)
        end
        
      end      
  end
  
  describe "login as admin" do
      
      before :each do
          @DM = create(:DM)
          session[:user_id] = @DM.id
          
          @CP = create(:representative)
          @company = create(:company, user_id: @CP.id )
          @scenario = create(:scenario1)
          @scenario_weight1 = create(:scenario_weight1, company_id: @company.id, scenario_id: @scenario.id)
          # @scenario_weight2 = create(:scenario_weight2, company_id: @company.id, scenario_id: @scenario.id)
      end
      
      describe "ScenarioWeightController#submit" do
        it "has no privilege and redirect_to scenarios_path" do
          get :submit, params:{:scenario_id => @scenario.id ,:sw => {@scenario_weight1.id =>{"weight"=>"343"}}}
          expect(flash[:danger]).to match("Do not meddle with other's scenarios!")
          expect(response).to redirect_to scenarios_path
        end
        
        it "update weight successfully and redirect_to scenarios_path" do
          @DM.create_scenario(@scenario)
          get :submit, params:{:scenario_id => @scenario.id ,:sw => {@scenario_weight1.id =>{"weight"=>"343"}}}
          expect(flash[:success]).to match("ScenarioWeights was successfully updated.")
          expect(response).to redirect_to scenarios_path
        end     
        
        it "weight contain invalid symbol and redirect_to edit_scenario_path(@scenario.id)" do
          @DM.create_scenario(@scenario)
          get :submit, params:{:scenario_id => @scenario.id ,:sw => {@scenario_weight1.id =>{"weight"=>"3a"}}}
          expect(flash[:danger]).to match("Weight Invalid, you need to type a float.")
          expect(response).to redirect_to edit_scenario_path(@scenario.id)
        end
        
      end      
  end
end
