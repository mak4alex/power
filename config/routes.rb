Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  resource :help, only: [:new, :create]
  resources :posts
end
