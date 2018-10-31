class PhotosController < ApplicationController
  before_action :login_as_host_or_guest, only: [:create]
  before_action :logged_in_host, only:[:destroy]
  
  def create
    @photo = Photo.new(photo_params)
    @photo.event_id = current_event.id
    #@photo = current_event.photos.build(photo_params)
    # ↑photo_paramsで:event_id渡しているので、buildでなくてnewするだけでphotoがevent_idに紐づくはずだったんだけど、
    #このままだとphotosのevent_idがEvent#idではなくEvent#nameの値が入ってしまうので(event/show.html.erbのhidden_field変えたから)
    #buildしてeventと紐づける。
    if @photo.save
      redirect_to event_path(current_event.name), flash: {success: "写真をアップロードしました"}
      #redirect_to event_pathだけではダメ。(どこのevent？ってなっちゃう)
      #引数をcurrent_eventと与えることで、event_idが入る。
      #redirect_to ("/events/#{@photo.event_id}"), flash: {success: "写真をアップロードしました"}
    else
      @event = current_event
      @event.id = current_event.name
      @photos = current_event.photos
      render "events/show"
      #renderはcontrollerを経由しないので、ここでviewで使っている変数(=ここの場合は@event、@photos)を
      #改めて定義してあげないと、値がnilだよって怒られる。
    end
  end
  
  def show
    @photo = Photo.find_by(id: params[:id])
  end
  
  def destroy
    @photo = Photo.find_by(id: params[:id])
    event = Event.find_by(id: @photo.event_id)
    #↑@photo.deleteしてしまうと、@photoからeventを取ってこられなくなってしまうから、
    #deleteする前に変数eventに@photoからとってきたイベントの情報を入れておく。
    @photo.delete
    redirect_to event_path(event.name), flash: {success: "写真を削除しました"}
  end
  
  private
    def photo_params
      params.require(:photo).permit(:image)
      #events/show(投稿フォーム)でhidden_fieldでフォームでevent_idを受け取るようにしているから、
      #strong parameterでevent_idをpermitしてあげる
      #→ヘルパーのcurrent_eventでハッシュで呼び出されるようにする
      
      #不正な値を取り込まないようにするというのがstrong parameterがある意味です。
      #permitの中に書かれているもの以外のキーを取り入れないため、
      #permit(:event_id)をしないとevent_idは取れないです。
    end
end