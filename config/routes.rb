Rails.application.routes.draw do

  #resources from user
  resources :users, only: [:index, :show, :create, :update, :destroy]
  get 'user_seller_score', to: 'users#seller_score'
  get 'user_buyer_score', to: 'users#buyer_score'

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
    #routes for bids
    resources :bids, only: [:index, :create]
    #routes for purchases
    resources :purchases, only: [:create]
  end

  #routes for origins
  resources :origins, only: [:index, :show, :create, :update, :destroy]

  #routes for commments
  resources :commments, only: [:show, :destroy]
  get 'user_commments', to: 'commments#index_user'

  #routes for bids
  resources :bids, only: [:show]
  get 'user_bids', to: 'bids#index_user'

  #routes for purchases
  resources :purchases, only: [:index, :show]
  get 'user_sales', to: 'purchases#sold_index'
  post 'buyer_score', to: 'purchases#set_buyer_score'
  post 'seller_score', to: 'purchases#set_seller_score'
  post 'purchase_shipped', to: 'purchases#set_was_shipped'
  post 'purchase_delivered', to: 'purchases#set_was_delivered'

  #resources :bids
  #resources :commments
  #resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
