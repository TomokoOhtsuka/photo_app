class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_current_host
  
  def set_current_host
    @current_host = Host.find_by(id: session[:host_id])
  end
end
