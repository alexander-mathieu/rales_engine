Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "customers.json", to: 'customers#index', as: :customers_index
      get "customers/:id.json", to: 'customers#show', as: :customers_show

      get "merchants.json", to: 'merchants#index', as: :merchants_index
      get "merchants/:id.json", to: 'merchants#show', as: :merchants_show

      get "transactions.json", to: 'transactions#index', as: :transactions_index
      get "transactions/:id.json", to: 'transactions#show', as: :transactions_show
    end
  end
end
