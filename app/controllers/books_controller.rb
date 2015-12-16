class BooksController < ApplicationController
  def search
    @search_form = SearchForm.new(params[:search_form])
    page = params[:page] || '1'
    @books, total = Book::search_amazon(@search_form.keyword, page)
    @books = Kaminari.paginate_array(@books, total_count: total).page(page).per(10)
  end
end