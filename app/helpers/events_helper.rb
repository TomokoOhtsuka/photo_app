module EventsHelper
  
  def current_event
    binding.pry
    if params[:event_id]
      @current_event ||= Event.find_by(id: params[:event_id])
    end
  end
  
end
