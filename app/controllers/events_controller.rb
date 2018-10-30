class EventsController < ApplicationController
  before_action :login_as_host_or_guest, only: [:show]
  before_action :logged_in_host,  only: [:new, :create, :index, :destroy]
  before_action :forbid_logged_in_host,  only:[:guest_login_view, :guest_login]
  before_action :forbid_logged_in_guest, only:[:guest_login_view, :guest_login]
  
  #－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
  
  #eventsの作成、修正、削除など
  def new
   @event = current_host.events.build if logged_in?
  end
  
  def create
    @host = current_host
    @event = current_host.events.build(event_params)
    if @event.save
      redirect_to events_path(@event), flash: { success: "イベントを作成しました" }
    else
      render :new
    end
  end
  
  def index
    #@host = Host.find(params[:id])
    #ここで@host = Host.find_by(…)とすると、URLに違う人のidを入れた時に見れちゃう。
    #sessionでcurrent_hostを定義しているから、@host=…などとしなくても、
    #コレ↓だけで値は取ってこれる！
    @events = current_host.events
  end
  
  def show #photos/newの役割も担う
      @photo = Photo.new
      @event = Event.find_by!(name: params[:id])
                        #！をつけることで、見つからなかった時に、「見つからなかったよ」とエラーを出してくれる
                        #！がないと、nilクラスにメソッドつけられないよっていうエラーが出てしまう。
      #@photos = current_event.photos
      @photos = @event.photos
  end

  def edit
    @event = Event.find_by!(name: params[:id])
  end
  
  def update
    @event = Event.find_by!(name: params[:id])
    if @event.update_attributes(event_params)
      redirect_to event_path(@event.name), flash: { success: "アルバム情報を編集しました" }
    else
      render :edit
    end
  end
  
  def destroy
    @event = Event.find_by!(name: params[:id])
    @event.destroy
    redirect_to events_path
    flash.now[:success] = "イベントを削除しました"
  end
  
  #－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
  
  #ゲストのログイン/ログアウトに関するアクション
  def guest_login_view # (GET)
    # ログイン画面をだす(newアクション的な役割)
    # photo = Photo.find_by(id: params[:id])
    # @event_id = current_event.id || photo.event_id
  end
  
  def guest_login # (POST:create的な役割)
    # if 合言葉が同じ
    if params[:event][:guest_password] == current_event.guest_password
    #    sessionに合言葉を入れる
      session[:guest_password] = params[:event][:guest_password]
      redirect_to event_path(current_event.name), flash: { success: "ログインしました" }
    else
      flash.now[:danger] = "ゲストパスワードを入力してください"
      render :guest_login_view
    end
  end
  
  def guest_logout
    session[:guest_password] = nil
    redirect_to login_event_path(current_event.name), flash: { success: "ログアウトしました" }
  end
  
  private
  #メソッドはprivateの中に書く必要がある
    def event_params
      params.require(:event).permit(:title, :name, :guest_password, :description)
                     #↑このeventはform_forからきている
    end
end