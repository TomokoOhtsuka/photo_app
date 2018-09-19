class EventsController < ApplicationController
  before_action :logged_in_host, only: [:create, :destroy]
  
  def new
  end
  
  def create
    @event = current_host.events.build(event_params)
    if @event.save
      redirect_to host_path(@host), flash: { success: "イベントを作成しました" }
    else
      render :new
    end
  end
  
  def destroy
  end
  
  private
    def event_params
      params.require(:event).permit(:title, :description)
    end
  
end
