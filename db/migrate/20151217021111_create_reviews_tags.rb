class CreateReviewsTags < ActiveRecord::Migration
  def change
    create_table :reviews_tags do |t|
      t.integer :review_id
      t.integer :tag_id
    end

    add_index :reviews_tags, [:review_id, :tag_id], unique: true
  end
end
