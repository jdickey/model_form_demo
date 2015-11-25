
Rails.application.routes.draw do
  resources :things, only: [:index]

  root 'things#index'
end
