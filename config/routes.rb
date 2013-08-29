Svadber::Application.routes.draw do
  root to: 'home#index'

  devise_for :users
  resources :guests, only: [:index, :new, :update, :destroy]
  resources :expenditures, only: [:create, :update, :destroy]
  resources :checklist, only: [:index, :create, :update, :destroy]
  resources :todos, except: [:new, :edit, :show]
  get '/budget' => 'expenditures#index'
  get '/todolist' => 'svadber#todos'
  get '/seating' => 'svadber#seating'
end
