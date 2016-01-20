class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book
  before_action :set_review, only: [:edit, :update, :destroy]

  def new
    @review = current_user.reviews.build(book: @book)
  end

  def create
    @review = current_user.reviews.build(book: @book)
    @review.save!
    respond_to do |format|
      format.html { redirect_to :back, notice: '本棚に登録しました' }
      format.js
    end
  end

  def edit
  end

  def update
    @review.update!(review_params)
    redirect_to edit_book_review_path(@review.book), notice: 'レビューを更新しました'
  end

  def destroy
    @review.destroy!
    redirect_to user_path(current_user), notice: '本棚から削除しました'
  end

  private
    def set_book
      @book = Book.find_by(asin: params[:book_asin])
    end

    def set_review
      @review = current_user.reviews.find_by(book: @book)
    end

    def review_params
      params.require(:review).permit(:status, :read_at, :rank, :category_id, :tag_names, :text)
    end
end
