module BooksHelper
  def update_review_button_to(book)
    button_to 'レビューを書く', edit_book_review_path(book), method: :get
  end

  def create_review_button_to(book)
    button_to '本棚に登録', book_review_path(book), method: :post, remote: true
  end

  def update_button_id(book)
    "book_#{book.asin}_update"
  end

  def create_button_id(book)
    "book_#{book.asin}_create"
  end

end
