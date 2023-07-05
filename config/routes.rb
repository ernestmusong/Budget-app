Rails.application.routes.draw do
    devise_for :users, controllers: { sessions: 'users/sessions' }
  
    root 'users#index'
    
    resources :users, only:[:index] do
      resources :categories, only: [:index, :create, :new] do
        resources :activities, only: [:index, :show, :create, :new]
      end
       
    end
    
    devise_scope :user do
      get 'users/new', to: 'users/registrations#new', as: 'new_user'
    end
    
    get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
  end
  
  