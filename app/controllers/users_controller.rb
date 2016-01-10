class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    @review_search_form = ReviewSearchForm.new(params[:review_search_form])
    @reviews = @user.reviews
    @reviews = @reviews.search(@review_search_form) if params[:review_search_form]
  end

  private
    def set_user
      @user = User.find_by(name: params[:name])
    end
end
