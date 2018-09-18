class HostsController < ApplicationController
  def new
    @host = Host.new
  end
  
  def create
    @host = Host.new(host_params)
    if @host.save
      log_in @host
      flash.now[:success] = "アカウントを作成しました"
      redirect_to("/hosts/#{@host.id}")
    else
      render("hosts/new")
    end
  end
  
  def show
    @host = Host.find_by(id: params[:id])
  end


    private
    
    def host_params
      params.require(:host).permit(:name, :email, :password, :password_confirmation)
    end
    
end