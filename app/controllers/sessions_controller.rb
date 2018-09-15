class SessionsController < ApplicationController
  def new
  end
  
  def create
    @host = Host.find_by(params[:user])
    if @host
      redirect_to("/hosts/#{@host.id}")
    else
      render("sessions/new")
    end
  end

end
