class Topic < ActiveRecord::Base
	#include Elasticsearch::Model
  #include Elasticsearch::Model::Callbacks
 include Tire::Model::Search
  include Tire::Model::Callbacks 
  
	belongs_to :user
	has_many :comments, dependent: :destroy
	#default_scope -> { order('created_at DESC') }
	#after_initialize :init
	validates :user_id, presence: true
	validates :subject, presence: true, length: {maximum: 50}
	validates :body, presence: true, length: {maximum: 1000}
	validates :professor_name, length: {maximum:30}
	# validates :course_number, presence: false, :numericality => { :only_integer => true }

	#index_name BONSAI_INDEX_NAME

    #def init
     # self.rating = 0       #will set the default value only if it's nil
    #end

	# searchable do
	# 	text :subject, :professor_name, :course_number
	# en

end
