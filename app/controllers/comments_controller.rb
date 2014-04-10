class CommentsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy, :new]
	before_action :correct_user,   only: :destroy

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
		if @comment.save
			flash[:success] = "Comment created!"
			redirect_to topic_path(@comment.topic_id)
		else
			logger.info ("============== #{@comment.errors.full_messages}")

			redirect_to main_path
		end
	end

	def destroy
		@comment.destroy
		redirect_to topic_path(@comment.topic_id)
	end

	private

	def comment_params
      		params.require(:comment).permit(:body, :topic_id)
   	end

	def correct_user
        @comment = current_user.comments.find_by(id: params[:id])
        redirect_to main_path if @comment.nil?
      end
end
