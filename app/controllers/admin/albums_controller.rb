class Admin::AlbumsController < ApplicationController
  load_and_authorize_resource
  before_action :album_support, only: [:new, :edit, :index]

  def index
    @search = @albums.search params[:q]
    @albums = @search.result.paginate page: params[:page],
      per_page: Settings.albums.order_per_page
  end

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

  def edit
  end

  def update
    if @album.update_attributes album_params
      flash[:success] = t "flash.update_success"
      redirect_to root_url
    else
      album_support
      flash[:danger] = t "flash.update_failed"
      redirect_to :back
    end
  end

  def destroy
    if @album.destroy
      flash[:success] = t "flash.delete_success"
    else
      flash[:danger] = t "flash.delete_failed"
    end
    redirect_to admin_albums_path
  end

  private
  def album_params
    params.require(:album).permit :name, :artist_id, :album_type, :user_id,
      songs_attributes: [:id, :name, :quality, :singer_id, :composer_id,
      :category_id, :_destroy]
  end

  def album_support
    @support = Supports::AlbumSupport.new @album
  end
end
