Rails.application.routes.draw do

  resources :clients, only: [:index, :show, :update]
  resources :gyms, only: [:index, :show, :update, :destroy]
  resources :memberships, only: [:index, :create, :destroy]
  
end
