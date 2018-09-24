class HostsController < ApplicationController
  before_action :logged_in_host, only: [:show, :edit, :update]
  
  def new
    @host = Host.new
  end
  
  def create
    @host = Host.new(host_params)
    if @host.save
      log_in @host
      redirect_to host_path(@host), flash: { success: "アカウントを作成しました" }
    else
      render :new
      #コントローラーの中はコロンつけてアクション名でいける！
    end
  end
  
  def show
    @host = Host.find(params[:id])
    #ここで@host = Host.find_by(…)とすると、URLに違う人のidを入れた時に見れちゃうから空でOK
    @events = @host.events.all
  end


    private
    
    def host_params
      params.require(:host).permit(:name, :email, :password, :password_confirmation)
    end
    
end