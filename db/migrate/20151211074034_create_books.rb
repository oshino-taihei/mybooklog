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
      t.string :image

      t.timestamps null: false
    end
  end
end
