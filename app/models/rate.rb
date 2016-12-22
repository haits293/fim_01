class Rate < ActiveRecord::Base
  belongs_to :rater, class_name: User.name
  belongs_to :rateable, polymorphic: true

  include PublicActivity::Model
  tracked owner: Proc.new{|controller, model| controller.current_user},
    recipient: Proc.new{|controller, model| model.rateable}
end
