class SongsController < ApplicationController
  load_resource only: :show

  def show
    @comments = @song.comments.map(&:hash_tree).reduce(:merge)
    @commentable = @song
  end
end
