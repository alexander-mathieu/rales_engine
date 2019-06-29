Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :items do
        get "/:id/merchant", to: "merchants#show"
        get "/:id/invoice_items", to: "invoice_items#index"

        get "/most_items", to: "most_items#index"
        get "/most_revenue", to: "most_revenue#index"

        get "/:id/best_day", to: "best_day#show"
      end

      namespace :invoices do
        get "/find", to: "search#show"
        get "/random", to: "search#show"
        get "/find_all", to: "search#index"
        
        get "/:id/items", to: "items#index"
        get "/:id/customer", to: "customers#show"
        get "/:id/merchant", to: "merchants#show"
        get "/:id/transactions", to: "transactions#index"
        get "/:id/invoice_items", to: "invoice_items#index"
      end

      namespace :invoice_items do
        get "/:id/item", to: "items#show"
        get "/:id/invoice", to: "invoices#show"
      end

      namespace :customers do
        get "/find", to: "search#show"
        get "/random", to: "search#show"
        get "/find_all", to: "search#index"

        get "/:id/invoices", to: "invoices#index"
        get "/:id/transactions", to: "transactions#index"

        get ":id/favorite_merchant", to: "favorite_merchant#show"
      end

      namespace :merchants do
        get "/find", to: "search#show"
        get "/random", to: "search#show"
        get "/find_all", to: "search#index"

        get "/revenue", to: "revenue#index"
        get "/:id/revenue", to: "revenue#show"

        get "/most_items", to: "most_items#index"
        get "/most_revenue", to: "most_revenue#index"

        get "/:id/items", to: "items#index"
        get "/:id/invoices", to: "invoices#index"

        get "/:id/favorite_customer", to: "favorite_customer#show"
        get "/:id/customers_with_pending_invoices", to: "customers_with_pending_invoices#index"
      end

      namespace :transactions do
        get "/:id/invoice", to: "invoices#show"
      end

      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
    end
  end
end
