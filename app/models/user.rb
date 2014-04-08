class User < ActiveRecord::Base
	has_many :topics, dependent: :destroy
	has_many :comments, dependent: :destroy
	before_save { self.email = email.downcase }
	before_create :create_remember_token
	validates :name, presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[csu\.]*fullerton\.edu\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: {minimum: 6}
 	validates :password_confirmation, presence: true


	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.hash(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_remember_token
			self.remember_token = User.hash(User.new_remember_token)
		end
end
