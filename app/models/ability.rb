class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.is_admin?
      can :manage, [User, Artist, Category, Album]
    else
      can :manage, Album
    end
    can :manage, Comment
  end
end
