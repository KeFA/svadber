Svadber::Application.routes.draw do
  root to: 'home#index'

  devise_for :users
  resources :guests, only: [:index, :new, :update, :destroy]
  resources :expenditures, only: [:create, :update, :destroy]
  get '/budget' => 'expenditures#index'
  scope '/checklist', controller: :checklist do
    get '' => :index, as: 'checklist'
    post '' => :create
    delete '' => :destroy
    put '' => :update
  end
end
