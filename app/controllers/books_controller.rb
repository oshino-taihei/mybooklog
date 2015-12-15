class BooksController < ApplicationController
  def search
    res = Amazon::Ecs.item_search("Ruby",
           :search_index   => 'Books',
           :response_group => 'Medium',
           :country        => 'jp'
         )

    @books = []
    res.items.each do |item|
      asin = item.get('ASIN')
      url = item.get('DetailPageURL')
      item_attributes = item.get_element('ItemAttributes')
      title = item_attributes.get('Title')
      image = item.get_hash('SmallImage')
      image_url = image["URL"]
      authors = item.get_elements('Author').map { |e| e.get_unescaped }
      publisher = item_attributes.get('Publisher')
      published_at = item_attributes.get('PublicationDate')
      list_price = item.get_element('ListPrice')
      if list_price
        price = list_price.get('Amount')
      end

     book = Book.new(asin: asin, url: url, title:title, image: image_url, author: authors.join(', '), publisher: publisher, published_at: published_at, price: price)
     @books << book
   end
  end
end
