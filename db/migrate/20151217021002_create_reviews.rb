class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id, null: false
      t.integer :book_id, null: false
      t.integer :status, default: 0, null: false
      t.date :read_at
      t.integer :rank, default: 0, null: false
      t.integer :category_id
      t.text :text

      t.timestamps null: false
    end

    add_index :reviews, [:user_id, :book_id], unique: true
  end
end
