class PhotosController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.feed.photos.build(photo_params)
    @photo.user = current_user
    if @photo.save
      flash[:notice] = "Photo has been successfully added"
    else
      flash[:error] = "There's been an error adding your photo"
    end
    redirect_to "/#{current_user.username}"
  end

  def show
    @photo = Photo.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  private

  def photo_params
    params.require(:photo).permit(:photo_url, :description)
  end

end
