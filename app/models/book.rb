class Book < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  validates :asin, presence: true, uniqueness: true

  MAX_ITEM_PAGE = 100 # Amazon Product Advertising APIの仕様におけるItemPageパラメータの上限

  def to_param
    asin
  end

  def self.search_amazon(keyword, page)
    res = Amazon::Ecs.item_search(
            keyword,
            search_index:   'Books',
            response_group: 'Medium',
            country:        'jp',
            item_page:      page
          )
    books = res.items.map do |item|
      Book.find_or_create_by!(asin: item.get('ASIN')) do |book|
        item_attributes = item.get_element('ItemAttributes')
        book.url = item.get('DetailPageURL')
        book.title = item_attributes.get('Title')
        book.small_image = item.get_hash('SmallImage').try!(:fetch, 'URL')
        book.medium_image = item.get_hash('MediumImage').try!(:fetch, 'URL')
        book.large_image = item.get_hash('LargeImage').try!(:fetch, 'URL')
        book.author = item.get_elements('Author').try!(:map) { |e| e.get_unescaped }.try!(:join, ',')
        book.publisher = item_attributes.get('Publisher')
        book.published_at = item_attributes.get('PublicationDate')
        book.price = item.get_element('ListPrice').try!(:get, 'Amount')
      end
    end
    total_pages = [res.total_pages, MAX_ITEM_PAGE].min
    [books, total_pages]
  end
end
