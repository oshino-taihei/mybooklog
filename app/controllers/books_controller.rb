class BooksController < ApplicationController
  def search
    @search_form = SearchForm.new(params[:search_form])
    @books = Book::search_amazon @search_form
  end
end
