class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(name: params[:name])
    @review_search_form = ReviewSearchForm.new(params[:review_search_form])
    @reviews = @user.reviews
    @reviews = @reviews.search(@review_search_form) if params[:review_search_form]
  end
  
end
