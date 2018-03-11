Rails.application.routes.draw do
  resource :session, controller: 'clearance/sessions', only: [:create]
  get '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  match '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out', via: [:get, :delete]

  root to: 'home#index'

  resources :territories, param: :slug do
    resource :map
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

  unless Rails.env.staging?
    get '/error', to: ->(env){ raise("Test Exception!") }
  end
end
