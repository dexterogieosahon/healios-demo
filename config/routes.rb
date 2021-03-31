Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login',  to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:create, :show] do
    resources :shortened_urls, only: [:new, :create]
  end

  get '/unshorten/:id', to: 'shortened_urls#show', as: 'unshorten'

  match '*unmatched', to: 'application#route_not_found', via: :all

  root 'home#index'
end
