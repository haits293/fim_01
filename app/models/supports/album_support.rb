class Supports::AlbumSupport
  attr_reader :album

  def initialize album
    @album = album
  end

  def album_types
    @album_types ||= Album.album_types.keys
  end

  def singers
    @singers ||= Artist.singer.pluck(:name, :id).to_h
  end

  def composers
    @composers ||= Artist.composer.pluck(:name, :id).to_h
  end

  def categories
    @categories ||= Category.pluck(:name, :id).to_h
  end

  def qualities
    @qualities ||= Song.qualities.keys
  end

  def who_perform id
    Artist.find_by(id: id).name
  end
end
