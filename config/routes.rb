Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  resources :helps, only: [:new, :create, :index]
  resources :posts do
    resources :comments, only: [:new, :create]
  end
end
