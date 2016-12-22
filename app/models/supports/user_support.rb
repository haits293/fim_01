class Supports::UserSupport
  def initialize user
    @user = user
  end

  def track activity
    track = if activity.trackable_type == Relationship.name
      if activity.key == "relationship.destroy"
        "unfollow"
      else
        "follow"
      end
    else
      activity.trackable.class.name.downcase
    end
  end
end
