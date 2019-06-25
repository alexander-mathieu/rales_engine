Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "customers.json", to: 'customers#index', as: :customers_index
      get "customers/:id.json", to: 'customers#show', as: :customers_show

      get "merchants.json", to: 'merchants#index', as: :merchants_index
      get "merchants/:id.json", to: 'merchants#show', as: :merchants_show

      get "transactions.json", to: 'transactions#index', as: :transactions_index
      get "transactions/:id.json", to: 'transactions#show', as: :transactions_show

      get "invoices.json", to: 'invoices#index', as: :invoices_index
      get "invoices/:id.json", to: 'invoices#show', as: :invoices_show

      get "items.json", to: 'items#index', as: :items_index
      get "items/:id.json", to: 'items#show', as: :items_show
    end
  end
end
