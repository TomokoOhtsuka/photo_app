class PhotosController < ApplicationController
  #before_action :logged_in_host, only:[:new, :create, :show, :destroy]

  def create
    binding.pry
    @photo = Photo.new(photo_params)
    #@photo = current_event.photos.build(photo_params)
    if @photo.save
      redirect_to photos_path, flash: {success: "写真をアップロードしました"}
    else
      render("events/index")
    end
  end
  
  def show
  end
  
  def destroy
  end
  
  private
    def photo_params
      params.require(:photo).permit(:image)
    end

end