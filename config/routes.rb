Svadber::Application.routes.draw do
  root to: 'home#index'

  devise_for :users
  resources :guests, only: [:index, :create, :update, :destroy]
  resources :expenditures, only: [:index, :create, :update, :destroy, :show]
  resources :checklist, only: [:index, :create, :update, :destroy]
  resources :todos, except: [:new, :edit, :show]
  resources :cars, only: [:index, :create, :update, :destroy, :show]
  get '/budget' => 'svadber#budget'
  get '/todolist' => 'svadber#todos'
  get '/seating' => 'svadber#seating'
  get '/guestslist' => 'svadber#guests'
  get '/carslist' => 'svadber#cars'
  get '/congratulants' => 'svadber#congratulants'

end
