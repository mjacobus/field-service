Rails.application.routes.draw do
  root to: 'territories#index'

  resources :territories, param: :slug do
    resources :householders
    resources :assignments, controller: 'territory_assignments'
  end

  resources :publishers

  resources :territory_assignments, only: [:index], as: :all_territory_assignments

  namespace :reports do
    resources :inactive_territories, only: [:index]
  end
end
