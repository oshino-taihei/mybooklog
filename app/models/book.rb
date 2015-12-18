class Book < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  MAX_ITEM_PAGE = 100 # Amazon Product Advertising APIの仕様におけるItemPageパラメータの上限

  # BookのURLでidの代わりにasin使うためにto_keyとto_paramをオーバーライド
  def to_key
    asin
  end
  def to_param
    asin
  end

  def self.search_amazon(keyword, page)
    # Amazon Product Advertising API で書籍検索する
    res = Amazon::Ecs.item_search(keyword,
           search_index:   'Books',
           response_group: 'Medium',
           country:        'jp',
           item_page:      page
         )

    # 書籍検索結果をBookモデルのリストに変換する
    # 各書籍データがBookテーブルに登録済みならばテーブルから書籍データを取得し、未登録ならば登録する
    books = res.items.map do |item|
      Book.find_or_create_by!(asin: item.get('ASIN')) do |book|
        item_attributes = item.get_element('ItemAttributes')
        book.url = item.get('DetailPageURL')
        book.title = item_attributes.get('Title')
        book.image = item.get_hash('SmallImage').try!(:fetch, "URL")
        book.author = item.get_elements('Author').try!(:map) { |e| e.get_unescaped }.join(', ')
        book.publisher = item_attributes.get('Publisher')
        book.published_at = item_attributes.get('PublicationDate')
        book.price = item.get_element('ListPrice').try!(:get, 'Amount')
      end
    end

    # 検索結果と検索ページ数(API仕様上の最大値を上限とする)を返す
    total_pages = [res.total_pages, MAX_ITEM_PAGE].min
    [books, total_pages]
  end
end
