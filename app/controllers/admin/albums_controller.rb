class Admin::AlbumsController < ApplicationController
  load_and_authorize_resource
  before_action :album_support, only: :new

  def new
    @album.songs.build
  end

  def create
    if @album.save
      flash[:success] = t "flash.create_success"
      redirect_to root_url
    else
      album_support
      flash[:danger] = t "flash.create_failed"
      redirect_to :back
    end
  end

  private
  def album_params
    params.require(:album).permit :name, :artist_id, :album_type, :user_id,
      songs_attributes: [:id, :name, :quality, :singer_id, :composer_id,
      :category_id]
  end

  def album_support
    @support = Supports::AlbumSupport.new @album
  end
end
