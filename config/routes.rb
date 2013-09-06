Svadber::Application.routes.draw do
  root to: 'home#index'

  devise_for :users
  resources :guests, only: [:index, :create, :update, :destroy]
  resources :expenditures, only: [:index, :create, :update, :destroy]
  resources :checklist, only: [:index, :create, :update, :destroy]
  resources :todos, except: [:new, :edit, :show]
  get '/budget' => 'svadber#budget'
  get '/todolist' => 'svadber#todos'
  get '/seating' => 'svadber#seating'
  get '/guestslist' => 'svadber#guests'
end
