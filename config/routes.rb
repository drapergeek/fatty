Fatty::Application.routes.draw do
  get '/auth/:provider/callback', to: 'fitbit_informations#create'
  resource 'welcome', only: [:show]
  resources :users, only: [:edit, :update]

  namespace :api do
    resources :stats, only: [:index]
  end

  root to: 'welcomes#show'
end
