module EventsHelper
  
  def current_event 
    # params[:id] => event_controllerのとき
    # params.require(:photo).permit(:event_id)[:event_id] => photo_controllerのとき
    #パラメーターの値は、コントローラーによって取ってくるものが違う！
    @event_id = params[:id] || params.require(:photo).permit(:event_id)[:event_id]
    #params.require(:photo).permit(:event_id)の結果が、
    # { event_id: 1 }というハッシュで返ってくるから、値をとるときは[:event_id]をつける必要がある
    photo = Photo.find_by(id: @event_id)
    @current_event ||= Event.find_by(id: @event_id) || photo.event_id
                                                    #events/showでlogoutならcurrent_eventで持ってこれるけど
                                                    #photos/index画面でlogoutするとevent_id持ってこれないから
                                                    #その場合はphotoに紐づいたイベントIDをもってくるようにする
  end
  
  def guest_logged_in?
      session[:guest_password].present?
      # sessionが入っているか(セッションの中身は合言葉でOK)
      # sessionsヘルパー
  end
end
