class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.follow(@user)
    redirect_to :back
  end

  def destroy
    current_user.unfollow(@user)
    redirect_to :back
  end

  private
    def set_user
      @user = User.find_by!(name: params[:user_name])
    end

end
