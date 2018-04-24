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
      get "/books/xls", to: "xlsexporter#books", format: "xlsx"
      resources :books
      get "/members/xls", to: "xlsexporter#members", format: "xlsx"
      resources :members, only: [:index, :show, :update, :destroy]
    end
  end
end
