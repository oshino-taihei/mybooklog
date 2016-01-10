class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    @review_search_form = ReviewSearchForm.new(params[:review_search_form])
    if params[:review_search_form]
      @reviews = @user.reviews.joins(:book).where('title like ?', "%#{@review_search_form.keyword}%")
    else
      @reviews = @user.reviews
    end
  end

  private
    def set_user
      @user = User.find_by(name: params[:name])
    end
end
