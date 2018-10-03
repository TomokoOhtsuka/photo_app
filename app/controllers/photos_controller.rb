class PhotosController < ApplicationController
  before_action :logged_in_host, only:[:create, :destroy]
  
  def create
    @photo = Photo.new(photo_params)
    #@photo = current_event.photos.build(photo_params)
    # ↑photo_paramsで:event_id渡しているので、buildでなくてnewするだけでphotoがevent_idに紐づく。
    if @photo.save
      redirect_to ("/events/#{@photo.event_id}"), flash: {success: "写真をアップロードしました"}
      #redirect_to events_pathにホントはしたいけど、そうするとphoto#showに連れていかれてしまう…
    else
      render "events/show"
    end
  end
  
  def destroy
  end
  
  private
    def photo_params
      params.require(:photo).permit(:image, :event_id)
      #events/show(投稿フォーム)でhidden_fieldでフォームでevent_idを受け取るようにしているから、
      #strong parameterでevent_idをpermitしてあげる
    end

end