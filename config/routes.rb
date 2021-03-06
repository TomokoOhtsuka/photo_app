Rails.application.routes.draw do
  get  'sessions/new'
  root 'home#top'
  get  "/about"  => "home#about"
  get  "/signup" => 'hosts#new'
  post "/signup" => "hosts#create"
  get  "/login"  => "sessions#new"
  post "/login"  => "sessions#create"
  post "/logout" => "sessions#destroy"

  #resourcesでは、次の7つがつくられる。
  #new, create, show, edit, update, index, destroy
  #使わないものがある場合、onlyで使うもの or exceptで使わないものを指定する
  resources :hosts
  #resources :account_activations, only: [:edit]
  resources :events do
    resources :photos, only:[:create, :show, :destroy]
    member do
      get    "/login"  => "events#guest_login_view"
      post   "/login"  => "events#guest_login"
      delete "/logout" => "events#guest_logout"
    end
  end
  #onlyとmemberの併用はこんなかんじで、
  #onlyがあればonlyで通常通り指定、その他に付け加えたいURLがあればmember do-endの間にで追加する。
  #events/1/photosなどとしたい場合は、resources eventsの中にresources photosをネストしてあげれば良い。
  #ネストした時のform_forの使い方：https://qiita.com/ayacai115/items/fbffe85e22986d8ea91a
  #ネストの使い方全般(viewやcontrollerの書き方など)：https://sil.hatenablog.com/entry/rails-nested-resource-by-scaffold
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #ルーティングを確認したいときは、コマンドにrake routesと打ち込むと見られる。
end
