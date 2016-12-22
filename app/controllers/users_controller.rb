class UsersController < ApplicationController
  load_resource
  before_action :authenticate_user!
  before_action :user_support, only: :show

  def show
    @followed = if current_user.following? @user
      current_user.active_relationships.
        find_by followed_id: @user.id
    else
      current_user.active_relationships.build
    end
    @activities = PublicActivity::Activity.user_activities(current_user).
      order_desc
  end

  private
  def user_support
    @support = Supports::UserSupport.new @user
  end
end
