class AddProfessorNameToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :professor_name, :string
  end
end
