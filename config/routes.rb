Rails.application.routes.draw do
  root to: 'territories#index'

  resources :territories do
    resources :householders
    resources :assignments, controller: 'territory_assignments'
  end

  resources :publishers

  resources :territory_assignments, only: [:index]
end
