class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    @review_search_form = ReviewSearchForm.new(params[:review_search_form])
    @reviews = @user.reviews
    if params[:review_search_form]
      @reviews = @reviews.joins(:book).where('title like ?', "%#{@review_search_form.keyword}%") unless @review_search_form.keyword.empty?
      @reviews = @reviews.where(status: @review_search_form.status) unless @review_search_form.status.empty?
      @reviews = @reviews.where(rank: @review_search_form.rank) unless @review_search_form.rank.empty?
      @reviews = @reviews.where(category_id: @review_search_form.category_id) unless @review_search_form.category_id.empty?
    end
  end

  private
    def set_user
      @user = User.find_by(name: params[:name])
    end
end
