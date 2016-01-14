class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:new, :create]
  before_action :set_book_and_review, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @review = current_user.reviews.build(book: @book)
  end

  def edit
  end

  def create
    @review = current_user.reviews.build(book: @book)

    respond_to do |format|
      if @review.save
        format.html { redirect_to :back, notice: '本棚に登録しました' }
        format.js
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to user_path(current_user), notice: 'レビューを更新しました' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: '本棚から削除しました' }
      format.json { head :no_content }
    end
  end

  private
    def set_book
      @book = Book.find_by(asin: params[:book_asin])
    end

    def set_book_and_review
      set_book
      @review = current_user.reviews.find_by(book: @book)
    end

    def review_params
      params.require(:review).permit(:status, :read_at, :rank, :category_id, :tag_names, :text)
    end
end
