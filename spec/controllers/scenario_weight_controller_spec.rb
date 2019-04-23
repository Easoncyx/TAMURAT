require 'rails_helper'

RSpec.describe ScenarioWeightController, type: :controller do

  describe "not login" do
      before :each do
          session[:user_id] = nil
      end
      
      describe "ScenarioWeightController#submit" do
          it 'should redirect to the page of login' do
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
          it 'should redirect to the root page' do
              post :submit
              expect(response).to redirect_to root_url
          end             
      end    
  
  end
  
  describe "login as admin" do
      
      before :each do
          @admin = create(:admin)
          session[:user_id] = @admin.id
          
          # @CP = create(:representative)
          # @company = create(:company, user_id: @CP.id )
          # @scenario = create(:scenario1)
          # @scenario_weight = create(:scenario_weight1, company_id: @company.id, scenario_id: @scenario.id)
      end
      
      # describe "ScenarioWeightController#submit" do
      #     it 'should redirect to the page of login' do
      #         post :submit
      #         expect(response).to redirect_to login_url
      #     end             
      # end 
      
      describe "ScenarioWeightController#submit" do
        it "returns http success" do
          get :submit
          expect(response).to have_http_status(:success)
        end
      end      
  end

end
