Rails.application.routes.draw do

  post 'scenario_weight/submit'
  get 'evidences/new'
  root   'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/activate',to: 'activate#activate'

  resources :users
  

  #questions
  resources :questions do
    collection { post :import}
  end
  
  #get '/questions/edit/:id', to: 'questions#edit', as: 'question_edit'

  #subcategory
  resources :subcategories
  #get '/subcategories/edit/:id', to: 'subcategories#edit', as: 'subcategory_edit'
  #category
  resources :categories
  #get '/categories/edit/:id', to: 'categories#edit', as: 'category_edit'

  resources :account_activations, only: [:edit]

  resources :privileges, only: [:index, :edit, :destroy]

  resources :scenarios

  #resources for password reset
  resources :password_resets,  only: [:new, :create, :edit, :update]

  resources :scales

  #resources for answers
  resources :answers
  #get '/answers/validator_index', to: 'answers#validator', as: "validator_index"
  #get '/answers/validator_index/:id', to: 'answers#show', as: "validator_show"
  #resources for companies

  resources :companies,  only: [:index, :update]

  resources :evidences

  resources :outputs, only: [:index, :show]
end
