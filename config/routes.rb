Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login',  to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users, only: [:create, :show]
  resources :sessions, only: [:new, :create, :destroy]

  match '*unmatched', to: 'application#route_not_found', via: :all

  root 'home#index'
end
