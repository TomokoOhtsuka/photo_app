class HostsController < ApplicationController
  before_action :forbid_logged_in_host
  
  def new
    @host = Host.new
  end
  
  def create
    @host = Host.new(host_params)
    if @host.save
      log_in @host
      redirect_to events_path(@host), flash: { success: "アカウントを作成しました" }
    else
      render :new
      #コントローラーの中はコロンつけてアクション名でいける！
    end
  end

    private
    
    def host_params
      params.require(:host).permit(:name, :email, :password, :password_confirmation)
    end
    
end