class Song < ApplicationRecord
  has_many :lyrics, dependent: :destroy
  has_many :ratings, as: :ratable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :artist_songs
  has_many :artists, through: :artist_songs
  has_many :album_songs
  has_many :albums, through: :album_songs

  enum quality: ["128kbps", "320kbps"]

  validates :quality, presence: true
  validates :audio_file_name, presence: true
  validates :audio_content_type, presence: true
  validates :audio_file_size, presence: true

  validate :composer_must_exist
  validate :singer_must_exist
  validate :category_must_exist

  has_attached_file :audio
  validates_attachment_content_type :audio,
    content_type: %w[audio/mpeg3 audio/mpeg, audio/ogg],
    message: I18n.t("activerecord.invalid_type")
  validates_attachment_size :audio, less_than: 20.megabytes

  private
  def composer_must_exist
    composer = Artist.find_by id: self.composer_id
    errors.add(:base, "Composer must exist") if composer.nil?
  end

  def singer_must_exist
    singer = Artist.find_by id: self.singer_id
    errors.add(:base, "Singer must exist") if singer.nil?
  end

  def category_must_exist
    category = Category.find_by id: self.category_id
    errors.add(:base, "Category must exist") if category.nil?
  end
end
