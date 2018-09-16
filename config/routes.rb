Rails.application.routes.draw do
  get 'sessions/new'
  root 'home#top'
  get "/about" => "home#about"
  get "/signup" => 'hosts#new'
  post "/signup" => "hosts#create"
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  post "/logout" => "sessions#destroy"
  resources :hosts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
