Svadber::Application.routes.draw do
  root to: 'home#index'

  devise_for :users
  resources :guests, only: [:index, :new, :update, :destroy]
  resources :expenditures, only: [:create, :update, :destroy]
  resources :checklist, path: '/checklist', only: [:create]
  match '/budget', to: 'expenditures#index'
  match '/checklist', to: 'checklist#index'
  match '/checklist', to: 'checklist#destroy', via: :delete
end
