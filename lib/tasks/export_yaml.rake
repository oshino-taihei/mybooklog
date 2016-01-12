namespace :export do
  namespace :yaml do
    desc "Export books table data to test/fixtures as YAML file"
    task book: :environment do

      def to_yaml(book)
        yaml = <<ENDOFYAML
#{book.asin}:
  title: #{book.title}
  asin: #{book.asin}
  author: #{book.author}
  publisher: #{book.publisher}
  published_at: #{book.published_at}
  price: #{book.price}
  url: #{book.url}
  small_image: #{book.small_image}
  medium_image: #{book.medium_image}
  large_image: #{book.large_image}
ENDOFYAML
        yaml
      end

      books = Book.all
      outfile = "test/fixtures/books.yml"
      File.open(outfile, "w") do |f|
        books.each do |book|
          f.print to_yaml(book)
        end
      end
      puts "  create #{outfile}"
    end

  desc "Export reviews table data to test/fixtures as YAML file"
    task review: :environment do
      def to_yaml(review)
        yaml = <<ENDOFYAML
#{review.id}:
  user_id: #{review.user_id}
  book_id: #{review.book_id}
  status: #{review[:status]}
  read_at: #{review.read_at}
  rank: #{review[:rank]}
  category_id: #{review.category_id}
  text: #{review.text}
ENDOFYAML
      yaml
      end

      reviews = Review.all
      outfile = "test/fixtures/reviews.yml"
      File.open(outfile, "w") do |f|
        reviews.each do |review|
          f.print to_yaml(review)
        end
      end
      puts "  create #{outfile}"
    end
  end
end
