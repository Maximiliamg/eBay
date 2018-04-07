Rails.application.routes.draw do

  #resources from user
  resources :users, only: [:index, :show, :create, :update, :destroy]
  # get 'users/:id', to: 'users#show' #What the code up do...

  #resources from session
  resources :sessions, only: :create
  delete 'sessions', to: 'sessions#destroy'

  #routes for admins
  namespace :users do
    get ':user_id/block/admin' , to: 'admins#block'
    get ':user_id/unblock/admin', to: 'admins#unblock'
    get 'blocks/admin', to: 'admins#index_block'
  end

  #routes for products
  resources :products, only: [:index, :show, :create, :update, :destroy] do
    #routes for commments
    resources :commments, only: [:index, :create]
  end

  #routes for origins
  resources :origins, only: [:index, :show, :create, :update, :destroy]

  #routes for commments
  resources :commments, only: [:show, :destroy]
  get 'user_commments', to: 'commments#index_user'

  #resources :carts
  #resources :purchases
  #resources :bids
  #resources :commments
  #resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
