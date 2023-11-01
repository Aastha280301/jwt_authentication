Rails.application.routes.draw do

  root to: 'welcomes#index'
  resources :welcomes
  resources :users, only: [:new]

  post '/users', to: 'users#create'
 
  resources :authentication, only: [:index]
  resources :ratings, only: [:new, :create]

  get 'products/check_role', to: 'products#check_role', as: 'check_role'
  post '/auth/login', to: 'authentication#login'
  get 'users/new_import_file', to: 'users#new_import_file', as: 'new_import_file'
  post 'users/update_password', to: 'users#update_password', as: 'update_password'
  post 'users/import_users', to: 'users#import_users', as: 'import_users'
  post 'orders/search', to: 'orders#search', as: 'search'
  post 'products/import_users', to: 'products#import_users'
  get 'products/new_import_file', to: 'products#new_import_file'

  resources :products do
    collection do
      get 'search'
    end
  end

  resources :products, only: [:new, :index, :show, :create]
  resources :orders, only: [:new, :create]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
