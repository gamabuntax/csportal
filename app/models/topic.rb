class Topic < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :subject, presence: true, length: {maximum: 100}
	validates :body, presence: true, length: {maximum: 200}
	validates :professor_name, presence: true, length: {maximum:30}
	validates :course_number, presence: true, length: {maximum:3}

	searchable do
		text :subject, :professor_name
		integer :course_number
	end
end
