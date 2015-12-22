module BooksHelper
  def review_link_to(book)
    if current_user.books.exists?(book)
      link_to 'レビューを書く', edit_book_review_path(book)
    else
      link_to '本棚に登録', book_review_path(book), method: :post
    end
  end
end
