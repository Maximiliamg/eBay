Rails.application.routes.draw do
  resources :products
  resources :blocked_users
  resources :blockeds
  resources :origins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
