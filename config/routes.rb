
Rails.application.routes.draw do
  resources :things, only: [:index, :new, :create]

  root 'things#index'
end
