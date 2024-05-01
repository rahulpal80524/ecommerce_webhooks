Rails.application.routes.draw do
  resources :products, only: [:create, :update]
  resources :orders
  resources :customers
end
