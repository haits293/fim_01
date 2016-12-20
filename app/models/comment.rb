class Comment < ApplicationRecord
  acts_as_tree order: "created_at DESC"

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
end
