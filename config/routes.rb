Svadber::Application.routes.draw do
  root to: 'home#index'

  devise_for :users
  resources :guests, only: [:index, :new, :update, :destroy]
  resources :expenditures, only: [:create, :update, :destroy]
  resources :checklist, only: [:index, :create, :update, :destroy]
  get '/budget' => 'expenditures#index'
end
