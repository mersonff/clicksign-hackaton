Rails.application.routes.draw do

  api_guard_routes for: 'users'

  resources :teams
  resources :stages
  resources :matches

  post '/matches/batch_import', to: 'match_batch_import#batch_import', as: :match_batch_import
end
