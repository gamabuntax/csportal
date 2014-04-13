class Topic < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :subject, presence: true, length: {maximum: 100}
	validates :body, presence: true, length: {maximum: 400}

	searchable do
		text :subject
	end
end
