class EventsController < ApplicationController
  before_action :logged_in_host, only: [:new, :create, :destroy]
  
  def new
   @event = current_host.events.build if logged_in?
  end
  
  def create
    @host = current_host
    @event = current_host.events.build(event_params)
    if @event.save
      redirect_to host_path(@host), flash: { success: "イベントを作成しました" }
    else
      render :new
    end
  end
  
  def show
    
  end
  
  def destroy
  end
  
  private
    def event_params
      params.require(:event).permit(:title, :description)
                     #↑このeventはform_forからきている
    end
  
end
