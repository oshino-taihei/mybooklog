class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @book_search_form = BookSearchForm.new(params[:book_search_form])
    if params[:book_search_form]
      page = params[:page] || '1'
      begin
        @books, total = Book.search_amazon(@book_search_form.keyword, page)
        @books = Kaminari.paginate_array(@books, total_count: total).page(page).per(10)
      rescue Amazon::RequestError => e
        flash.now[:alert] = "問合せがエラーとなりました。しばらくたってから、再検索して下さい。"
        logger.error "Amazon Advertising APIへの問合せ中にエラーが発生しました。:#{e}"
      end
    end
  end

end
