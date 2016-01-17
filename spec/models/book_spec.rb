require 'rails_helper'

describe Book, type: :model do
  it 'asinがあれば正常であること' do
    book = build(:book)
    expect(book).to be_valid
  end

  it 'asinがなければエラーであること' do
    book = build(:book, asin: nil)
    expect(book).not_to be_valid
  end

  it 'asinに重複があればエラーであること' do
    same_asin = "12345678"
    book1 = create(:book, asin: same_asin)
    book2 = build(:book, asin: same_asin)
    expect(book2).not_to be_valid
  end

  it 'Amazon APIへの問合せが正常に行えること' do
    keyword = 'Ruby'
    page = 1
    books = Book::search_amazon(keyword, page)
    expect(books.count).to be > 0
  end
end
