class ApplicationController < ActionController::Base
  include ApplicationHelper
  include SessionsHelper
  include EventsHelper
  
  before_action :set_current_host
  #before_action :set_current_event
  
  def set_current_host
    @current_host = Host.find_by(id: session[:host_id])
  end
  
  private
      def logged_in_guest
        unless guest_logged_in?
          store_location
          #flash[:danger] = "ゲストログインしてください"
          redirect_to login_event_path(current_event.name)
        end
      end

    def logged_in_host
      unless logged_in? #sessionsヘルパーからメソッド呼び出し
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_path
      end
    end
    
    def login_as_host_or_guest
      unless logged_in?
        logged_in_guest
      end
    end  
    
    def forbid_logged_in_host
      if logged_in?
        flash[:danger] = "すでにログインしています"
        redirect_to events_path
      end
    end
    
    def forbid_logged_in_guest
      if guest_logged_in?
        flash[:danger] = "すでにゲストとしてログインしています"
        redirect_to event_path(current_event.name)
      end
    end
end
