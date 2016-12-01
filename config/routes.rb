Rails.application.routes.draw do
  root to: 'shares#current_shares_home'

  resources :stations, shallow: true do
    resources :groups do
      resources :shares do
        resources :members
      end
    end
  end

  resources :stations
  resources :groups
  resources :shares
  resources :members
  resources :settings

  get '/register' => 'shares#new', as: :register
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/activate_share/:id/:token', to: 'activations#activate_share', as: :activate_share

  get '/request_password_reset/new', to: 'password_reset#request_password_reset', as: :request_password_reset
  post '/request_password_reset', to: 'password_reset#create_password_reset'
  get '/reset_password/:id/:token', to: 'password_reset#reset_password', as: :reset_password
  patch '/reset_password', to: 'password_reset#set_new_password'
end
