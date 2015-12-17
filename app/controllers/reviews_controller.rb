class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :set_book_review, only: [:show, :edit, :update, :destroy]

  def index
    @reviews = current_user.reviews
  end

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
        format.html { redirect_to book_path(@book.asin), notice: 'Review was successfully created.' }
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
        format.html { redirect_to reviews_path, notice: 'Review was successfully updated.' }
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
      format.html { redirect_to reviews_path, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_book
      @book = Book.find_by(asin: params[:book_asin])
    end

    def set_book_review
      @review = current_user.reviews.find_by(book: @book)
    end

    def review_params
      params.require(:review).permit(:status, :read_at, :rank, :category_id, :text)
    end
end
