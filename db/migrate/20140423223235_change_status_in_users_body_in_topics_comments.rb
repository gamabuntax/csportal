class ChangeStatusInUsersBodyInTopicsComments < ActiveRecord::Migration
  def change
  	rename_column :users, :status, :education_level
  	change_column :topics, :body, :text
  	change_column :comments, :body, :text
  end
end
