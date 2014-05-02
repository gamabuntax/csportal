class SessionsController < ApplicationController
	def new
		if signed_in?
			redirect_to root_url
		end

	end

	def create

		if signed_in?
			redirect_to root_url
		end

		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			#Sign the user in and redirect to the user's show page
			sign_in user
			redirect_to root_url
		else 
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
