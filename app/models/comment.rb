class Comment < ApplicationRecord
  acts_as_tree order: "created_at DESC"

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy

  include PublicActivity::Model
  tracked owner: Proc.new{|controller, model| controller.current_user},
    recipient: Proc.new{|controller, model| model.commentable}
end
