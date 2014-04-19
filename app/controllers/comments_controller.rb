class CommentsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy, :new, :edit, :update]
	before_action :correct_user,   only: [:destroy, :edit, :update]

	def new
		logger.info("===================== #{params[:id]}")
		@topic = Topic.find(params[:id])
		@user = current_user if signed_in?
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
			flash[:error] = "Please comment the topic"
			redirect_to topic_path(@comment.topic_id)
		end
	end

	def edit
	    @user = current_user if signed_in?
	    @comment = Comment.find(params[:id])
  end

	def update
	    @comment = Comment.find(params[:id])
	    if @comment.update_attributes(comment_params)
	      flash.now[:success] = "Comment updated"
	      redirect_to topic_path(@comment.topic_id)
	    else
	      render 'edit'
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
