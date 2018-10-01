class PhotosController < ApplicationController
  before_action :logged_in_host, only:[:create, :destroy]
  
  def create
    @photo = Photo.new(photo_params)
    binding.pry
    #@photo = current_event.photos.build(photo_params)
    if @photo.save
      redirect_to event_path, flash: {success: "写真をアップロードしました"}
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