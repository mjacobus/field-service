Rails.application.routes.draw do
  root to: 'territories#index'

  resources :territories, param: :slug do
    resources :householders
    resources :assignments, controller: 'territory_assignments'
  end

  resources :publishers

  resources :territory_assignments, only: [:index, :update], as: :all_territory_assignments do
    collection do
      get :edit
    end
  end

  namespace :reports do
    resources :inactive_territories, only: [:index]
  end

  namespace :api, defaults: { format: :json } do
    resources :territories, param: :slug do
      resources :householders
    end

    resources :publishers
  end

  match 'app/*path', to: 'frontend#index', via: :all
  get 'static/media/*asset', to: 'frontend#redirect_to_asset'
end
