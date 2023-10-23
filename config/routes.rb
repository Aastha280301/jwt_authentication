Rails.application.routes.draw do

  root to: 'welcomes#index'
  resources :welcomes
  resources :users, only: [:new]

  post '/users', to: 'users#create'
 
  resources :authentication, only: [:index]
  resources :ratings, only: [:new, :create]

  post '/auth/login', to: 'authentication#login'
  post 'users/update_password', to: 'users#update_password', as: 'update_password'
  post 'users/import_users', to: 'users#import_users', as: 'import_users'
  post 'orders/search', to: 'orders#search', as: 'search'

  resources :products, only: [:new, :index, :create]
  resources :orders, only: [:new, :create]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
