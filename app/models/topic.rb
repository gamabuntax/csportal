class Topic < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	default_scope -> { order('created_at DESC') }
	#after_initialize :init
	validates :user_id, presence: true
	validates :subject, presence: true, length: {maximum: 100}
	validates :body, presence: true, length: {maximum: 200}
	validates :professor_name, presence: true, length: {maximum:30}
	validates :course_number, presence: true, length: {maximum:3}


    #def init
     # self.rating = 0       #will set the default value only if it's nil
    #end

	searchable do
		text :subject, :professor_name, :course_number
	end

	
end
