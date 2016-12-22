class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  include PublicActivity::Model
  tracked owner: Proc.new{|controller, model| controller.current_user},
    recipient: Proc.new{|controller, model| model.followed}
end
