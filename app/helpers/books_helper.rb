module BooksHelper
  def update_button_id(book)
    "book_#{book.asin}_update"
  end

  def create_button_id(book)
    "book_#{book.asin}_create"
  end
end
