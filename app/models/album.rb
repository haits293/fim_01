class Album < ApplicationRecord
  has_many :album_songs, dependent: :destroy, inverse_of: :album
  has_many :ratings, as: :rateable, class_name: Rate.name,
    dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :songs, through: :album_songs

  belongs_to :category
  belongs_to :user

  accepts_nested_attributes_for :songs, allow_destroy: true,
    reject_if: :all_blank

  enum album_type: [:album, :favorite]

  validates :name, presence: true, length: {maximum: 255}
  validates :album_type, presence: true

  validate :at_least_one_song, on: [:create, :update]

  ratyrate_rateable "evaluation"

  private
  def at_least_one_song
    if self.album?
      i = 0
      self.songs.each do |song|
        i += 1 unless song.marked_for_destruction?
      end
      if i < 1
        errors.add :base, I18n.t("activerecord.at_least_one_song")
      end
    end
  end
end
