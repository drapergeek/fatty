Fatty::Application.routes.draw do
  get '/auth/:provider/callback', to: 'fitbit_informations#create'
  resource 'welcome', only: [:show]
  root to: 'welcomes#show'
end
