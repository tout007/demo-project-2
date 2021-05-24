Rails.application.routes.draw do
  get 'welcome/index'
  devise_for :users
  
  root 'admins#home'
  
  resources :limits do
    collection do
      get :add_limit
    end

    member do
      get :remove
      put :update
    end
  end
 
  resources :expenses do
    collection do
      get :add_expense 
    end
    
    member do
      # put :update
    end
  end
  
  get 'sessions/login'
  
  get '/admins/home', to:'admins#home'
  
  # resources :sessions, :only => [:login, :create, :destroy]
  resources :admins
  
  resources :categories do
    collection do
      get :add_category   
    end

    member do
      put :update
    end
  end

  get 'home/welcome'
  resources :users do 
    # collection do 
    #   get :edit_profile
    #   put :update_profile
    #   get :logout        
    #   delete :destroy
    # end
    
    member do     
      get :block
    end
  end 
 
  # get 'login' => 'sessions#login', :as => 'login' #static routes 
  # get 'signup' => 'users#signup', :as => 'signup' 

  # # devise_scope :user do
  #   get 'sign_in', to: 'devise/sessions#new'
  # end

  # devise_for :users, skip: :all

  # devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }

  # devise_for :users, controllers: { sessions: 'users/sessions' }
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
