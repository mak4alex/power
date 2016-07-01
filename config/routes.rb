Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  resources :helps, only: [:new, :create, :index]
  resources :posts
end
