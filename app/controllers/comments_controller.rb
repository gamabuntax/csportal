class CommentsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy, :new]
	def new 
		@user = current_user
		@comment = current_user.comments.build if signed_in?
	end

	def create
		@user = current_user
		@comment = current_user.comments.build(comment_params)
		#@comment.topic_id = params[:id]
		if @comment.save
			flash[:success] = "Comment created!"
		else
			redirect_to main_path
		end
	end

	def destroy
	end

	private

	def comment_params
      		params.require(:comment).permit(:body)
   	end

end
