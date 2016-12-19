class UsersController < ApplicationController
  load_resource
  before_action :authenticate_user!

  def show
    @followed = if current_user.following? @user
      current_user.active_relationships.
        find_by followed_id: @user.id
    else
      current_user.active_relationships.build
    end
  end
end
