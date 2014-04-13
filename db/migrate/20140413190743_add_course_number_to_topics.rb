class AddCourseNumberToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :course_number, :int
  end
end
