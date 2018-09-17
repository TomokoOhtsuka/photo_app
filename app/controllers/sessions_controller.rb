class SessionsController < ApplicationController
  def new
  end
  
  def create
    host = Host.find_by(params[:host])
    if host
      log_in host
      redirect_to("/hosts/#{host.id}")
    else
      render("sessions/new")
    end
  end
  
  def destroy
    log_out
    redirect_to("/")
  end

end
