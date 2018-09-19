class HostsController < ApplicationController
  def new
    @host = Host.new
  end
  
  def create
    @host = Host.new(host_params)
    if @host.save
      log_in @host
      redirect_to host_path(@host), flash: { success: "アカウントを作成しました" }
    else
      render :new  #コントローラーの中はコロンつけてアクション名でいける！
    end
  end
  
  def show
    #ここで@host = Host.find_by(…)とすると、URLに違う人のidを入れた時に見れちゃうから空でOK
  end


    private
    
    def host_params
      params.require(:host).permit(:name, :email, :password, :password_confirmation)
    end
    
end