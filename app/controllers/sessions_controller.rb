class SessionsController < ApplicationController
  def new
  end
  
  def create
    @host = Host.find_by(email: params[:session][:emali])#.downcaseとしたいけど、入れるとエラー出る
    if @host && @host.authenticate(params[:session][:password])
      log_in @host
      redirect_to("/hosts/#{@host.id}")
      flash.now[:success] = "ログインしました"
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが正しくありません"
      render("sessions/new")
    end
  end
  
  def destroy
    log_out
    flash.now[:success] = "ログアウトしました"
    redirect_to("/")
  end

end
