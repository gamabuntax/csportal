class TopicsController < ApplicationController
	 before_action :signed_in_user, only: [:create, :destroy, :new]

	def new
    @user = current_user
		@topic = current_user.topics.build if signed_in?
	end

  	def create
      @user = current_user
  		@topic = current_user.topics.build(topic_params)
  		if @topic.save
  			flash[:success] = "Topic created!"
  			redirect_to root_url
  		else
  			render 'new'
  		end	
 	end

  	def destroy
  	end

  	private

    	def topic_params
      		params.require(:topic).permit(:title,:content)
    	end
end
