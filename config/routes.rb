Rails.application.routes.draw do
  root 'welcome#index'

  get '/auth/google_oauth2', as: 'provider_name_login'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/excursions/new', to: 'excursions#new'
  post '/excursions/create', to: 'excursions#create'
  #edit excursion requires excursion id to edit
  get '/excursions/edit/:id', to: 'excursions#edit', as: :excursions_edit
  patch '/excursions/:id', to: 'excursions#update', as: :excursions_update
  get '/dashboard', to: 'dashboard#show'
end
