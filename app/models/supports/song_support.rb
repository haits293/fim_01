class Supports::SongSupport
  def initialize song
    @song = song
  end

  def comments
    @comments = @song.comments.map{|comment| comment.hash_tree(limit_depth: 2)}
      .reduce(:merge)
  end
end
