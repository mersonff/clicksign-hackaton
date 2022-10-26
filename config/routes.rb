Rails.application.routes.draw do

  api_guard_routes for: 'users'

  resources :stages, only: %i[create destroy]
  resources :matches

  post '/matches/batch_import', to: 'match_batch_import#batch_import', as: :match_batch_import
end
