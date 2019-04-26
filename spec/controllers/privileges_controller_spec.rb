require 'rails_helper'

RSpec.describe PrivilegesController, type: :controller do

    describe 'login as admin' do
        
            before :each do
                @admin = create(:admin)
                @DM = create(:DM)
                session[:user_id] = @admin.id
                
                @scenario = create(:scenario1)
            end    
            
            describe "PrivilegesController#index" do
                it 'have scenario_id and render index' do
                    get :index, params: {scenario_id: @scenario.id}
                    expect(response).to render_template('index')
                end    

                it 'without scenario_id and redirect_to scenarios_url' do
                    get :index
                    expect(response).to redirect_to scenarios_url
                end    
                
                it 'should find the created @scenario and @Dm ' do
                    get :index, params: {scenario_id: @scenario.id}
                    expect(assigns("privileges")[0]).to match @DM
                    expect(assigns("scenario")).to match @scenario
                end                    
            end            
            
            describe "AnswersController#edit" do
                
                it 'redirect_to privileges_url if chosen DM do not have scenario' do
                    get :edit, params:{id: @DM.id, scenario_id: @scenario.id  }
                    expect(flash[:success]).to match("Successfully Assigned!")
                    expect(response).to redirect_to privileges_url(scenario_id: @scenario.id)
                end         
                
                it 'redirect_to privileges_url if chosen DM have scenario' do
                    @DM.create_scenario(@scenario)
                    get :edit, params:{id: @DM.id, scenario_id: @scenario.id  }
                    expect(flash[:success]).to match("Already assigned.")
                    expect(response).to redirect_to privileges_url(scenario_id: @scenario.id)
                end                    
                
                # it 'redirect_to privileges_url if chosen DM do not have scenario' do
                #     get :edit, params:{id: @DM.id, scenario_id: @scenario.id  }
                #     expect(assigns("user").scenarios).to match @scenario
                # end            
        
            end
            
            describe "AnswersController#destroy" do
                
                it 'redirect_to privileges_url if chosen DM do not have scenario' do
                    delete :destroy, params:{id: @DM.id, scenario_id: @scenario.id  }
                    expect(flash[:danger]).to match("DM does not have this scenario!")
                    expect(response).to redirect_to privileges_url(scenario_id: @scenario.id)
                end         
                
                it 'redirect_to privileges_url if chosen DM have scenario' do
                    @DM.create_scenario(@scenario)
                    delete :destroy, params:{id: @DM.id, scenario_id: @scenario.id  }
                    expect(flash[:success]).to match("Successfully Deleted!")
                    expect(response).to redirect_to privileges_url(scenario_id: @scenario.id)
                end                 
       
            end
            
    end   
    
    describe 'not login' do
        describe "PrivilegesController#index" do
            it 'have scenario_id and render index' do
                get :index
                expect(response).to redirect_to login_url
            end    
        end            
    end

    describe 'login as DM or Validator' do
        describe "PrivilegesController#index" do
            it 'have scenario_id and render index' do
                @CP = create(:representative)
                session[:user_id] = @CP.id
                get :index
                expect(response).to redirect_to root_url
            end    
        end       
        
        describe "PrivilegesController#index" do
            it 'have scenario_id and render index' do
                @validator = create(:validator)
                session[:user_id] = @validator.id
                get :index
                expect(response).to redirect_to root_url
            end    
        end          
        
    end

end
