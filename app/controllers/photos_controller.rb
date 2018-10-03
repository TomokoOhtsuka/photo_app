class PhotosController < ApplicationController
  before_action :logged_in_host, only:[:create, :destroy]
  
  def create
    @photo = Photo.new(photo_params)
    #@photo = current_event.photos.build(photo_params)
    if @photo.save
      redirect_to ("/events/#{@photo.event_id}"), flash: {success: "写真をアップロードしました"}
    else
      render "events/show"
    end
  end
  
  def destroy
  end
  
  private
    def photo_params
      params.require(:photo).permit(:image, :event_id)
    end

end