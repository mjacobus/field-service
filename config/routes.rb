Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'territories#index'

  resources :territories do
    resources :householders
  end
end
