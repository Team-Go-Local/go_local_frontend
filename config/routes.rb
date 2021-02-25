Rails.application.routes.draw do
  root 'welcome#index'

  get 'auth/google_oauth2', as: 'provider_name_login'
  get '/auth/:provider/callback', to: 'sessions#create'
end
