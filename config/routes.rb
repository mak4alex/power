Rails.application.routes.draw do
  
  root 'posts#index'
  
  devise_for :users
  
  resources :helps, only: [:new, :create, :index]
  
  resources :posts do
    
    resources :comments, only: [:new, :create]
    
    member do
      post 'favourites', to: 'favourites#create'
      delete 'favourites', to: 'favourites#destroy'
    end
  
  end
end
