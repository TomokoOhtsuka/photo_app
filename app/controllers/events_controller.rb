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
    # ログイン画面をだす
  end
  
  def guest_login # (POST)
    # if 合言葉が同じ
    #    sessionに合言葉を入れる
    #    redirect_to show
    # else
    #    render :guest_login_view
    # end
  end
  
  def destroy
  end
  
  private
  #メソッドはprivateの中に書く必要がある
    def event_params
      params.require(:event).permit(:title, :description)
                     #↑このeventはform_forからきている
    end
    
    def guest_log_in?
      # sessionが入っているか(セッションの中身は合言葉でOK)
      # sessionsヘルパー
    end
end