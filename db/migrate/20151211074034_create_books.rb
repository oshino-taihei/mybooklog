class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :asin
      t.string :author
      t.string :publisher
      t.date :published_at
      t.integer :price
      t.string :url
      t.string :small_image
      t.string :medium_image
      t.string :large_image

      t.timestamps null: false
    end

    add_index :books, :asin, unique: true
  end
end
