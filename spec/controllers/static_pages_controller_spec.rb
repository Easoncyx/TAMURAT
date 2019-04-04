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


   
   
   
   
    
end