
Rails.application.routes.draw do
  resources :things, only: [:index, :new]

  root 'things#index'
end
