require 'rails_helper'

RSpec.describe Book, type: :model do
  it "asinがなければエラーであること" do
    book = Book.new
    book.asin = nil
    expect(book).not_to be_valid
  end

  it "asinがあれば正常であること" do
    book = Book.new
    book.asin = "ASIN"
    expect(book).to be_valid
  end

  it "Amazon APIへの問合せが正常に行えること" do
    keyword = 'Ruby'
    page = 1
    books = Book::search_amazon(keyword, page)
    expect(books.count).to be > 0
  end
end
