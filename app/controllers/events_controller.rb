class EventsController < ApplicationController
  before_action :logged_in_host, only: [:new, :create, :index, :show, :destroy]
  
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
  
  def show
    if logged_in?
      #@photo = current_event.photos.build
      @photo = Photo.new
      @photos = current_event.photos
    else
      render :login_view
    end
  end
  
  def guest_login_view # (GET)
    # ログイン画面をだす(newアクション的な役割)
    @event_id = current_event.id
  end
  
  def guest_login # (POST:create的な役割)
    # if 合言葉が同じ
    binding.pry
    if params[:event][:guest_password].to_i == current_event.guest_password
    #    sessionに合言葉を入れる
      session[:guest_passeword] = params[:guest_password]
      redirect_to event_path(current_event), flash: { success: "イベントにログインしました" }
    else
      flash.now[:danger] = "ゲストパスワードを入力してください"
      render :guest_login_view
    end
  end

  def destroy
  end
  
  private
  #メソッドはprivateの中に書く必要がある
    def event_params
      params.require(:event).permit(:title, :guest_password, :description)
                     #↑このeventはform_forからきている
    end
    
    def guest_log_in?
      # sessionが入っているか(セッションの中身は合言葉でOK)
      # sessionsヘルパー
    end
end