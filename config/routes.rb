Rails.application.routes.draw do
  mount_devise_token_auth_for 'Member', at: 'api/v1/members', only: [:registrations]
  namespace :api do
    namespace :v1 do
      get "/books/total", to: "books#total"
      get "/books/xls", to: "xlsexporter#books", format: "xlsx"
      resources :books
      get "/members/xls", to: "xlsexporter#members", format: "xlsx"
      get "/members/check_admin", to: "members#check_admin"
      get "/members/self", to: "members#self"
      resources :members, only: [:index, :show, :update, :destroy]
    end
  end
end
