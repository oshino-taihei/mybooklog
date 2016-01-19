class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:id])
    current_user.follow(@user)
    redirect_to :back
  end

  def destroy
    @follow = Follow.find(params[:id])
    current_user.unfollow(@follow.to_user)
    redirect_to :back
  end
  
end
