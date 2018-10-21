class SessionsController < ApplicationController
  before_action :forbid_logged_in_host, except:[:destroy]
  
  def new
  end
  
  def create
    @host = Host.find_by(email: params[:session][:email]&.downcase)
    #&を入れることでnilの場合、無視してくれる
    # http://secret-garden.hatenablog.com/entry/2016/09/02/000000

    if @host && @host.authenticate(params[:session][:password])
      #models/hosts.rbでhas_secure_passwordを設定したので、authenticateメソッドが使えるようになる。
      #PWは簡単に参照できないようになっているが、authenticate(照合したいPW)とすればTorFが返ってくるしくみ
      log_in @host
      redirect_to events_path(@event), flash: { success: "ログインしました" }
      #redirect_toの場合はflashは第二引数にハッシュで渡してあげる
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが正しくありません"
      render("sessions/new")
    end
  end
  
  def destroy
    log_out
    redirect_to root_path, flash: { success: "ログアウトしました" }
  end

end
