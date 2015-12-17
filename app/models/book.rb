class Book < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  MAX_PAGES = 100

  # Amazon Product Advertising API にキーワードで書籍検索する
  # 検索結果をBookテーブルに保存した上で、returnする
  def self.search_amazon(keyword, page)
    res = Amazon::Ecs.item_search(keyword,
           search_index:   'Books',
           response_group: 'Medium',
           country:        'jp',
           item_page:      page
         )
    books = []
    res.items.each do |item|
      asin = item.get('ASIN')
      url = item.get('DetailPageURL')
      item_attributes = item.get_element('ItemAttributes')
      title = item_attributes.get('Title')
      image = item.get_hash('SmallImage')
      image_url = image["URL"] if image
      author = item.get_elements('Author')
      authors = author.map { |e| e.get_unescaped }.join(', ') if author
      publisher = item_attributes.get('Publisher')
      published_at = item_attributes.get('PublicationDate')
      list_price = item.get_element('ListPrice')
      if list_price
        price = list_price.get('Amount')
      end

      book = Book.find_or_create_by(asin: asin) do |b|
        b.url = url
        b.title = title
        b.image = image_url
        b.author = authors
        b.publisher = publisher
        b.published_at = published_at
        b.price = price
      end
      books << book
    end
  total = [res.total_pages, MAX_PAGES].min
  [books, total]
  end
end
