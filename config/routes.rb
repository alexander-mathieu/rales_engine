Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/revenue", to: "total_revenue#index"
        get "/most_items", to: "most_items#index"
        get "/most_revenue", to: "most_revenue#index"

        get "/:id/items", to: "items#index"
        get "/:id/invoices", to: "invoices#index"
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
