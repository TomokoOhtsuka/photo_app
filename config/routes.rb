Rails.application.routes.draw do
  get 'sessions/new'
  root 'home#top'
  get "/about" => "home#about"
  get "/signup" => 'hosts#new'
  post "/signup" => "hosts#create"
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  post "/logout" => "sessions#destroy"
  #get "/hosts/:id/events/new" => "events#new"
  #post "/hosts/:id/events/new" => "events#create"
  resources :hosts
  resources :events, only:[:new, :create, :index, :destroy]
  resources :photos, only:[:create, :index, :destroy]
  #resourcesでは、次の7つがつくられる。
  #new, create, show, edit, update, index, destroy
  #使わないものがある場合、onlyで使うものだけ　or exceptで使わないものを指定する
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #ルーティングを確認したいときは、コマンドにrake routesと打ち込むと見られる。
end
