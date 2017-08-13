Rails.application.routes.draw do
  root  'static_page#home'
  get   '/signup', to: 'users#new'
  post  '/signup', to: 'users#create'
  resources :users
end
