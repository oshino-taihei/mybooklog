class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show]

  def search
    @search_form = SearchForm.new(params[:search_form])
    if params[:search_form]
      page = params[:page] || '1'
      @books, total = Book::search_amazon(@search_form.keyword, page)
      @books = Kaminari.paginate_array(@books, total_count: total).page(page).per(10)
    end
  end

  def show
  end

  private
    def set_book
      @book = Book.find_by(asin: params[:asin])
    end
end
