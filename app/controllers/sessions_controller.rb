class SessionsController < ApplicationController
  def new
  end
  
  def create
    @host = Host.find_by(params[:host])
    if @host
      redirect_to("/hosts/#{@host.id}")
    else
      render("sessions/new")
    end
  end
  
  def destroy
    session.destroy
    redirect_to("/")
  end

end
