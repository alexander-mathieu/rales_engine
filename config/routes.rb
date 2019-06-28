Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :items do
        get "/most_revenue", to: "most_revenue#index"
      end

      namespace :invoices do
        get "/:id/items", to: "items#index"
        get "/:id/customer", to: "customer#index"
        get "/:id/merchant", to: "merchant#index"
        get "/:id/transactions", to: "transactions#index"
        get "/:id/invoice_items", to: "invoice_items#index"
      end

      namespace :merchants do
        get "/revenue", to: "revenue#index"
        get "/:id/revenue", to: "revenue#show"

        get "/most_items", to: "most_items#index"
        get "/most_revenue", to: "most_revenue#index"

        get "/:id/items", to: "items#index"
        get "/:id/invoices", to: "invoices#index"

        get ":id/favorite_customer", to: "favorite_customer#index"
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
