require 'rails_helper'


RSpec.describe StaticPagesController, type: :controller do
    
    describe "StaticPagesController#home" do
        it 'should render the home in views/static_pages' do
            get :home
            expect(response).to render_template('home')
        end        
        
    end
    
    describe "StaticPagesController#about" do
        it 'should render the about in views/static_pages' do
            get :about
            expect(response).to render_template('about')
        end         
        
    end
    
    describe "StaticPagesController#help" do
        before :each do
            @category = create(:category)
            @sub = create(:sub, :category_id => @category.id)
        end        
        
        
        it 'should render the help in views/static_pages' do
            get :help
            expect(response).to render_template('help')
        end       
        
    end
    describe "StaticPagesController#contact" do
        it 'should render the contact in views/static_pages' do
            get :contact
            expect(response).to render_template('contact')
        end        
        
    end

    # describe "login as admins or validators" do
    #     before :each do
    #         @admin = create(:admin)
    #         session[:user_id] = @admin.id
    #     end   
    #     describe "StaticPagesController#home" do
    #         it 'should render the home in views/static_pages' do
    #             get :home
    #             expect(response).to render_template('home')
    #         end        
    #         it 'should render the home in views/static_pages' do
    #             get :home
    #             expect(response).to render_template('home')
    #         end               
    #     end        
    # end
   
   
   
    
end