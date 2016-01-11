class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @book_search_form = BookSearchForm.new(params[:book_search_form])
    if params[:book_search_form]
      page = params[:page] || '1'
      @books, total = Book::search_amazon(@book_search_form.keyword, page)
      @books = Kaminari.paginate_array(@books, total_count: total).page(page).per(10)
    end
  end

end
