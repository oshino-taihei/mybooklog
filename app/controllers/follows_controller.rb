class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:create]
  before_action :set_follow, only: [:destroy]

  def create
    current_user.follow(@user)
    redirect_to :back
  end

  def destroy
    current_user.unfollow(@follow.to_user)
    redirect_to :back
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def set_follow
      @follow = Follow.find(params[:id])
    end
end
