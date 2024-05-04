Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      get "/categories/all", to: "category#fetch_all"
      get "/categories", to: "category#paginate"
      post "/category", to: "category#store"
      get "/category/:uid", to: "category#get_by_uid"
      put "category/:uid", to: "category#update"
      delete "/category/:uid", to: "category#delete"

      get "/products/all", to: "product#fetch_all"
      get "/products", to: "product#paginate"
      post "/product", to: "product#store"
      get "/product/:uid", to: "product#get_by_uid"
      put "/product/:uid", to: "product#update"
      delete "/product/:uid", to: "product#delete"

      post "/order", to: "order#store"

      post "/transaction", to: "transaction#store"
    end
  end
end
