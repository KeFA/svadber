Svadber::Application.routes.draw do
  root to: 'home#index'

  devise_for :users
  resources :guests, only: [:index, :new, :update, :destroy]
  resources :expenditures, only: [:create, :update, :destroy]
  match '/budget', to: 'expenditures#index'
end
