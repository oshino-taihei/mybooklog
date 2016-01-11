namespace :export do
  namespace :yaml do
    desc "Export table data to test/fixtures as YAML file"
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
      outfile = "test/fixtures/books.yml.gen"
      File.open(outfile, "w") do |f|
        books.each do |book|
          f.print to_yaml(book)
          f.puts ""
        end
      end
      puts "  create #{outfile}"
    end
  end
end
