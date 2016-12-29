Rails.application.routes.draw do
  root to: 'territories#index'

  resources :territories do
    resources :householders
  end
end
