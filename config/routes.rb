Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      get "/users/:id/check_admin", to: "users#check_admin"

      get "/books/total", to: "books#total"
      resources :books

      post "/auths", to: "auths#create"
      delete "/auths", to: "auths#destroy"
    end
  end
end
