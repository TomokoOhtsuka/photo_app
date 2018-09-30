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
  resources :events, only:[:new, :create, :index, :show, :destroy]
  resources :photos, only:[:create, :destroy]
  #resourcesでは、次の7つがつくられる。
  #new, create, show, edit, update, index, destroy
  #使わないものがある場合、onlyで使うもの or exceptで使わないものを指定する
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #ルーティングを確認したいときは、コマンドにrake routesと打ち込むと見られる。
end
