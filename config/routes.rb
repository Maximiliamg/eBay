Rails.application.routes.draw do

  #resources from user
  resources :users, only: [:index, :show, :create]
  # get 'users/:id', to: 'users#show' #What the code up do...
  put 'users', to: 'users#update'
  delete 'users', to: 'users#destroy'

  #resources from session
  resources :sessions, only: :create
  delete 'sessions', to: 'sessions#destroy'

  #routes for admins
  namespace :users do
    put ':user_id/admin', to: 'admins#update'
    delete ':user_id/admin', to: 'admins#destroy'
    get ':user_id/block/admin' , to: 'admins#block'
    get ':user_id/unblock/admin', to: 'admins#unblock'
    get 'blocks/admin', to: 'admins#index_block'
  end


  resources :carts
  resources :purchases
  resources :bids
  resources :commments
  resources :products
  resources :blocked_users
  resources :origins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
