Rails.application.routes.draw do
  resources :users
  resources :books
  get '/books/total', to: "books#total"
  post '/auths', to: "auths#create"
  delete '/auths', to: "auths#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
