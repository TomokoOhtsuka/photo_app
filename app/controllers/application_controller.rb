class ApplicationController < ActionController::Base
  include SessionsHelper
  include EventsHelper
  
  before_action :set_current_host
  before_action :set_current_event
  
  def set_current_host
    @current_host = Host.find_by(id: session[:host_id])
  end
  
  def set_current_event
    @current_event = Event.find_by(id: session[:event_id])
  end
  
  private
    def logged_in_host
      unless logged_in? #sessionsヘルパーからメソッド呼び出し
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_path
      end
    end
end
