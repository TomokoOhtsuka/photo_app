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
    @photo = current_event.photos.build
  end
  
  def destroy
  end
  
  private
    def event_params
      params.require(:event).permit(:title, :description)
                     #↑このeventはform_forからきている
    end
  
end
