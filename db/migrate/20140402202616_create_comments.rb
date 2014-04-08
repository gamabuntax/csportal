class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body
      t.integer :user_id
      t.integer :topic_id

      t.timestamps
    end
    add_index :comments, [:user_id, :created_at]
    add_index :comments, [:topic_id, :created_at]
  end
end
