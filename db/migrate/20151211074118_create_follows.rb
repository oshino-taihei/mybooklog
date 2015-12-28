class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :from_user_id
      t.integer :to_user_id

      t.timestamps null: false
    end
    add_index :follows, :from_user_id
    add_index :follows, :to_user_id
    add_index :follows, [:from_user_id, :to_user_id], unique: true
  end
end
