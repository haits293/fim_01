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
  validates :name, presence: true

  validate :composer_must_exist
  validate :singer_must_exist
  validate :category_must_exist

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
