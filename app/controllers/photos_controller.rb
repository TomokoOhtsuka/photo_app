class PhotosController < ApplicationController
  before_action :login_as_host_or_guest, only: [:create]
  before_action :logged_in_host, only:[:destroy]
  
  def create
    #if !logged_in?
     # logged_in_guest
    #end
    
    @photo = Photo.new(photo_params)
    #@photo = current_event.photos.build(photo_params)
    # ↑photo_paramsで:event_id渡しているので、buildでなくてnewするだけでphotoがevent_idに紐づく。
    if @photo.save
      redirect_to event_path(current_event), flash: {success: "写真をアップロードしました"}
      #redirect_to event_pathだけではダメ。(どこのevent？ってなっちゃう)
      #引数をcurrent_eventと与えることで、event_idが入る。
      #redirect_to ("/events/#{@photo.event_id}"), flash: {success: "写真をアップロードしました"}
    else
      @photos = current_event.photos
      render "events/show"
      #renderはcontrollerを経由しないので、ここでviewで使っている変数(=ここの場合は@photos)を
      #改めて定義してあげないと、値がnilだよって怒られる。
    end
  end
  
  def show
    @photo = Photo.find_by(id: params[:id])
  end
  
  def destroy
    @photo = Photo.find_by(id: params[:id])
    event_page = @photo.event_id
    @photo.delete
    redirect_to event_path(event_page)
  end
  
  private
    def photo_params
      params.require(:photo).permit(:image, :event_id)
      #events/show(投稿フォーム)でhidden_fieldでフォームでevent_idを受け取るようにしているから、
      #strong parameterでevent_idをpermitしてあげる
      #→ヘルパーのcurrent_eventでハッシュで呼び出されるようにする
    end
end