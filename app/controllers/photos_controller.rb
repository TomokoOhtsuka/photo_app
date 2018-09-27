class PhotosController < ApplicationController
  before_action :logged_in_host, only:[:new, :create, :show, :destroy]

  def new
  end
  
  def create
  end
  
  def show
  end
  
  def destroy
  end

end