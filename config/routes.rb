Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "intro#show"
  get "/intro", to: "intro#show"
  get "/about", to: "about#show"
  resources :articles
end
