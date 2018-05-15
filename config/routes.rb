Rails.application.routes.draw do
  root 'home#index'

  resources :coins, only: [:show]
  resources :predictions, only: [:index]
end
