Rails.application.routes.draw do
  root 'home#index'

  resources :coins, only: [:show]
end
