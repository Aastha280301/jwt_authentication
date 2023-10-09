Rails.application.routes.draw do
 
  resources :users
  post '/auth/login', to: 'authentication#login'

  post 'users/update_password', to: 'users#update_password', as: 'update_password'
  post 'users/import_users', to: 'users#import_users', as: 'import_users'

  resources :products

end
