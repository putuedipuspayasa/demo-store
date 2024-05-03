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
      get "/category/:uid", to: "category#get_by_uid"
      post "category", to: "category#store"
      put "category/:uid", to: "category#update"
      delete "/category/:uid", to: "category#delete"
    end
  end
end
