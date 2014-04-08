class CommentsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy, :new]
	def new
		logger.info("===================== #{params[:id]}")
		@topic = Topic.find(params[:id])
		@user = current_user
		@comment = current_user.comments.build if signed_in?
	end

	def create
		@user = current_user
		logger.info ("============= #{comment_params} ")
		@comment = current_user.comments.build(comment_params)
		#somehow it didnt register both of the foreign key id...
		#something wrong right here. when i try to create it.. it fails.
		#it didnt get both the id
		#@comment.topic_id = params[:id]
		if @comment.save
			flash[:success] = "Comment created!"
			redirect_to main_path
		else
			logger.info ("============== #{@comment.errors.full_messages}")

			redirect_to main_path
		end
	end

	def destroy
	end

	private

	def comment_params
      		params.require(:comment).permit(:body, :topic_id)
   	end

end
