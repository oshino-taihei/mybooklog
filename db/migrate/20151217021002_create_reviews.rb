class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :status
      t.date :read_at
      t.integer :rank
      t.integer :category_id
      t.text :text

      t.timestamps null: false
    end
  end
end
