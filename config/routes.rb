Rails.application.routes.draw do
  root   'static_page#home'
  get    '/signup', to: 'users#new'
  post   '/signup', to: 'users#create'
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :user_account_activations, only: [:edit]
  resources :password_resets,          only: [:new, :create, :edit, :update]
  resources :tickets,                  only: [:new, :create, :edit, :update]
end
