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
    member do     
      get :block
    end
  end 
  
  namespace :api do
    namespace :v1 do
      resources :expenses
      resources :categories
      resources :users
      resources :limits
      resources :facts
    end
  end

end
 