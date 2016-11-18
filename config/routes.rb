Rails.application.routes.draw do
  root 'stations#index'
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
end
