Rails.application.routes.draw do


  mount_devise_token_auth_for 'Member', at: 'api/v2/members', except: [:registrations]
  namespace :api do
    namespace :v1 do
      resources :users
      get "/users/:id/check_admin", to: "users#check_admin"

      get "/books/total", to: "books#total"
      resources :books

      post "/auths", to: "auths#create"
      delete "/auths", to: "auths#destroy"
    end
    namespace :v2 do
      get "/books/total", to: "books#total"
      resources :books
      resources :members, only: [:index, :show, :update, :destroy]

      get "/ree", to: "hacker#ree"
    end
  end
end
