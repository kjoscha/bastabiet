Rails.application.routes.draw do
  root 'stations#index'
  resources :stations, shallow: true do
    resources :groups do
      resources :shares
    end
  end

  resources :stations
  resources :groups
  resources :shares
end
