class User < ApplicationRecord
  acts_as_paranoid
  ratyrate_rater

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :ratings, as: :ratable, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :lyrics, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  devise :database_authenticatable, :registerable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  validates :name, presence: true, length: {maximum: 50}

  enum gender: [:male, :female]

  ATTRIBUTES_PARAMS = [:name, :gender, :date_of_birth, :email,
    :password, :password_confirmation]

  scope :all_customer, -> {where is_admin: false}

  def current_user? user
    self == user
  end

  class << self
    def from_omniauth auth
      User.find_or_create_by email: auth.info.email do |user|
        user.email = auth.info.email
        user.name = auth.info.name
        user.password = Devise.friendly_token[0, 20]
      end
    end

    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.auth_data"] &&
          session["devise.auth_data"]["extra"]["raw_info"]
          user.email = data["email"]
        end
      end
    end
  end

  def follow other_user
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end
end
