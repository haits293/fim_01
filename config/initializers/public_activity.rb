PublicActivity::Activity.class_eval do
  scope :order_desc, -> {order created_at: :desc}
  scope :user_activities, -> (user) {where(owner_id: user.following.
    pluck(:id).push(user.id), owner_type: "User")}
end
