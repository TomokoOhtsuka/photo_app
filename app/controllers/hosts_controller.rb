class HostsController < ApplicationController
  before_action :forbid_logged_in_host, except: [:edit, :update]
  
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
      #同一コントローラー内でrenderする場合はアクション名をシンボルで渡してあげればOK！
    end
  end

  def edit
    @host = Host.find_by!(id: params[:id])
  end
  
  def update
    @host = Host.find_by!(id: params[:id])
    if @host.update_attributes(host_params)
            #updete_attributesについて：https://www.sejuku.net/blog/62009
      redirect_to events_path(@host), flash: { success: "アカウント情報を編集しました" }
    else
      render :edit
    end
  end  
  
  
    private
    
      def host_params
        params.require(:host).permit(:name, :email, :password, :password_confirmation)
        #strong parameterの詳細な説明はphotos_controllerにある
      end
    
end