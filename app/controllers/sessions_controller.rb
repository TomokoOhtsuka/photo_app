class SessionsController < ApplicationController
  def new
  end
  
  def create
    @host = Host.find_by(email: params[:session][:email]&.downcase)
    #&を入れることでnilの場合、無視してくれる
    # http://secret-garden.hatenablog.com/entry/2016/09/02/000000

    if @host && @host.authenticate(params[:session][:password])
      log_in @host
      redirect_to host_path(@host), flash: { success: "ログインしました" }
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
