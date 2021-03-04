Rails.application.routes.draw do
  root 'welcome#index'

  get '/auth/google_oauth2', as: 'provider_name_login'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/excursions/new', to: 'excursions#new'
  get '/excursions/:id', to: 'excursions#show', as: :excursions_show
  post '/excursions/create', to: 'excursions#create'
  get '/excursions/edit/:id', to: 'excursions#edit', as: :excursions_edit
  patch '/excursions/:id', to: 'excursions#update', as: :excursions_update
  delete '/excursions/:id', to: 'excursions#destroy', as: :excursions_destroy
  get '/dashboard', to: 'dashboard#show'
  get '/explore', to: 'explore#index'
  get '/explore/search', to: 'explore#search'
  post '/excursion/:id/save', to: 'excursions#favorite', as: :favorite
end
