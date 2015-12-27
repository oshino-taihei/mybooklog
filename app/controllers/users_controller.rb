class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show

  end

  private
    def set_user
      @user = User.find_by(name: params[:name])
    end
end
