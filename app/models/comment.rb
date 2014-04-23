class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :topic
	validates :user_id, presence: true
	# validates :topic_id, presence: true
	validates :body, presence: true, length: {minimum: 10, maximum: 500}
end
