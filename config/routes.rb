Rails.application.routes.draw do
  root 'sessions#new'

  resources :stations, shallow: true do
    resources :groups do
      resources :shares do
        resources :offers
      end
    end
  end

  resources :stations
  resources :groups
  resources :shares
  resources :offers

  get '/register' => 'shares#new', as: :register
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
