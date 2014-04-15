class AddRatingToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :rating, :integer, default: 0
  end
end
