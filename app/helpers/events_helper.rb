module EventsHelper
  
  def current_event
    if params[:id]
      @current_event ||= Event.find_by(id: params[:id])
    end
  end
  
end
