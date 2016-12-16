class Admin::ArtistsController < ApplicationController
  load_and_authorize_resource
  before_action :artist_support, only: [:new, :edit]
  def index
    @search = @artists.search params[:q]
    @artists = @search.result.paginate page: params[:page],
      per_page: Settings.artists.order_per_page
  end

  def show
  end

  def new
  end

  def create
    if @artist.save
      flash[:success] = t "flash.artists_create_success"
      redirect_to root_url
    else
      artist_support
      flash[:info] = t "flash.artists_create_failed"
      render :new
    end
  end

  def edit
  end

  def update
    if @artist.update_attributes artist_params
      flash[:success] = t "flash.artists_update_success"
      redirect_to admin_artists_url
    else
      artist_support
      flash[:danger] = t "flash.artists_update_failed"
      render :edit
    end
  end

  def destroy
    if @artist.destroy
      flash[:success] = t "flash.artists_destroy_success"
    else
      flash[:info] = t "flash.artists_destroy_failed"
    end
    redirect_to :back
  end

  private
  def artist_params
    params.require(:artist).permit :name, :gender, :date_of_birth,
      :type_of_music, :artist_type
  end

  def artist_support
    @support = Supports::ArtistSupport.new @artist
  end
end
