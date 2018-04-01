Rails.application.routes.draw do

  #resources from user
  resources :users, only: [:index, :show, :create]
  # get 'users/:id', to: 'users#show' #What the code up do...
  put 'users', to: 'users#update'
  delete 'users', to: 'users#destroy'


  resources :carts
  resources :purchases
  resources :bids
  resources :commments
  resources :products
  resources :blocked_users
  resources :origins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
