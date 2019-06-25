Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "merchants.json", to: 'merchants#index', as: :merchants_index
      get "merchants/:id.json", to: 'merchants#show', as: :merchants_show
    end
  end
end
