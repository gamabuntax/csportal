class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :subject
      t.string :body
      t.integer :user_id

      t.timestamps
    end
    add_index :topics, [:user_id, :created_at]
  end
end
