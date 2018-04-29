Rails.application.routes.draw do

  #resources from user
  resources :users, only: [:index, :show, :create, :update, :destroy]
  get 'user_seller_score/:id', to: 'users#seller_score'
  get 'user_buyer_score/:id', to: 'users#buyer_score'

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
    #route for finishing an auction
    post 'auctions', to: 'purchases#finish_auction'
    #route for pictures
    put 'upload_pictures', to: 'pictures#product'
    delete 'product_picture/:product_picture_id', to: 'pictures#destroy'
    resources :pictures, only: [:index]
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
  put 'buyer_score', to: 'purchases#set_buyer_score'
  put 'seller_score', to: 'purchases#set_seller_score'
  put 'purchase_shipped', to: 'purchases#set_was_shipped'
  put 'purchase_delivered', to: 'purchases#set_was_delivered'
  #route for profile pictures
  put 'profile_pictures', to: 'pictures#profile'
  put 'product_picture/:product_picture_id/set_cover', to: 'pictures#set_picture_as_cover'

  #resources :bids
  #resources :commments
  #resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end