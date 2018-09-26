class HostsController < ApplicationController
  before_action :logged_in_host, only: [:new, :create, :show]
  
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
    #とはいえ、ここで@hostを定義しないと、作成したイベント一覧を掲載することができない…？
    @events = @host.events.all
    #@event = current_host.events.build if logged_in? ←event#newで定義
  end


    private
    
    def host_params
      params.require(:host).permit(:name, :email, :password, :password_confirmation)
    end
    
end