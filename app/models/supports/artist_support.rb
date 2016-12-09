class Supports::ArtistSupport
  attr_reader :artist

  def initialize artist
    @artist = artist
  end

  def genders
    @genders ||= Artist.genders.keys
  end

  def type_of_musics
    @type_of_musics ||= Artist.type_of_musics.keys
  end

  def artist_types
    @artist_types ||= Artist.artist_types.keys
  end
end
