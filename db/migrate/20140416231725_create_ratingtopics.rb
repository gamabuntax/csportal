class CreateRatingtopics < ActiveRecord::Migration
  def change
    create_table :ratingtopics do |t|
      t.integer :topic_id
      t.integer :user_id

      t.timestamps
    end
  end
end
