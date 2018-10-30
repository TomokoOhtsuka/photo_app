module EventsHelper
  
  def current_event
    #↓メモ化：@_current_eventに値が入っていればそれをそのまま、入っていなければ、beginからendの処理で@_current_eventに値を入れる
    #二度目以降はbeginからendの処理をやらずして変数を使用できる(いちいちDBに問い合わせをする必要がなくなる)
    @_current_event ||= begin
      #event_id = params[:id] || params.require(:photo).permit(:event_id)[:event_id]
    event_id = params[:id] || params.require(:photo).permit(:event_name)[:event_name] || params.require(:photo).permit(:event_id)[:event_id]
                              #params[:photo][:event_name] → params[:photo]がnilだったときに、エラーが出る
                              #params.dig(:photo, :event_name)
    #binding.pry
      Event.find_by!(name: event_id)
    # params[:id] => event_controllerのとき
    # params.require(:photo).permit(:event_id)[:event_id] => photo_controllerのとき
    #パラメーターの値は、コントent_ローラーによって取ってくるものが違う！
    # @event_id = params[:id] || params.require(:photo).permit(:event_id)[:event_id]
    #params.require(:photo).permit(:event_id)の結果が、
    # { event_id: 1 }というハッシュで返ってくるから、値をとるときは[:event_id]をつける必要がある
    #photo = Photo.find_by(id: @event_id)
    #@current_event ||= Event.find_by(name: @event_id) || photo.event_id
                                                    #events/showでlogoutならcurrent_eventで持ってこれるけど
                                                    #photos/index画面でlogoutするとevent_id持ってこれないから
                                                    #その場合はphotoに紐づいたイベントIDをもってくるようにする
    end
  end
  
  def guest_logged_in?
      session[:guest_password].present?
      # sessionが入っているか(セッションの中身は合言葉でOK)
      # sessionsヘルパー
  end
end
